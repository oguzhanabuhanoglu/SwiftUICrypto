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
    @Published var sortOptions: SortOptions = .holdings
    
    @Published var searchText: String = ""
    var isLoading: Bool = false
    
    // To get api call resutls from data service
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOptions {
        case rank, reversedRank, holdings, reversedHoldings, price, reversedPrice
    }
    
    init(){
        addSubscribers()
    }
    
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // hızlı işlemler için 0.5 saniye es verip kodun sonrasını ona göre çalıştıracak
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        
        // updates portfoliCoins
        // i already subscribed to sorted and filtered allCoins here so i just need to add holding sorting here
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)

        
        // updates market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePorfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    // MARK: mapping coins
    private func filterAndSortCoins(text: String, startingCoins: [CoinModel], sort: SortOptions) -> [CoinModel] {
        var sortedCoins = filteredCoins(text: text, startingCoins: startingCoins)
        sortCoins(sort: sort, coins: &sortedCoins)
        return sortedCoins
    }

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
    
    private func sortCoins(sort: SortOptions, coins: inout [CoinModel])  {
        switch sort {
        case .rank, .holdings:
             coins.sort(by: { $0.rank < $1.rank })
        case .reversedRank, .reversedHoldings:
             coins.sort(by: { $0.rank > $1.rank })
        case .price:
             coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .reversedPrice:
             coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOptions {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .reversedHoldings:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    
    // MARK: mapping portfolio coins
    private func mapPortfolioCoins(coins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        coins.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.id == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }

    // MARK: mapping market data
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticsModel(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24H Volume", value: data.volume)
        let btcDominance = StatisticsModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins.map({ $0.currentHoldingsValue }).reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
           
        
        let portfolio = StatisticsModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith6Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}





