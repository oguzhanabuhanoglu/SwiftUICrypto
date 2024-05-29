//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 24.05.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var statistics: [StatisticsModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    // To get api call resutls from data service
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // hızlı işlemler için 0.5 saniye es verip kodun sonrasını ona göre çalıştıracak
            .map { (text, startingCoins) -> [CoinModel] in
                filteredCoins(text: text, startingCoins: startingCoins)
            }
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        

        // updates market data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        // updates portfoliCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels.compactMap { (coin) -> CoinModel? in
                    guard let entity = portfolioEntities.first(where: { $0.id == coin.id }) else {
                        return nil
                    }
                    return coin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePorfolio(coin: coin, amount: amount)
    }
    
}



// MARK: mapping coins
private func filteredCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
        return startingCoins
    }
    
    let lowercasedText = text.lowercased()
    
    return startingCoins.filter { coin -> Bool in
        return coin.name.lowercased().contains(lowercasedText) ||
        coin.symbol.lowercased().contains(lowercasedText) ||
        coin.id.lowercased().contains(lowercasedText)
    }
}

// MARK: mapping market data
private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticsModel] {
    var stats: [StatisticsModel] = []
    
    guard let data = marketDataModel else {
        return stats
    }
    
    let marketCap = StatisticsModel(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    let volume = StatisticsModel(title: "24H Volume", value: data.volume)
    let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
    let portfolio = StatisticsModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
    
    stats.append(contentsOf: [
        marketCap,
        volume,
        btcDominance,
        portfolio
    ])
    return stats
}

