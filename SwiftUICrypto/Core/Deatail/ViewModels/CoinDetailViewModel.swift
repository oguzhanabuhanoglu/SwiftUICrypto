//
//  CoinDetailViewModel.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 31.05.2024.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticsModel] = []
    @Published var additionalStatistics: [StatisticsModel] = []
    
    @Published var coin: CoinModel
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancelables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map({ (coinDetailModel, coinModel) -> (overview: [StatisticsModel], additional: [StatisticsModel]) in
                
                // overview data
                let price = coinModel.currentPrice.asCurrencyWith6Decimals()
                let pricePercentaChange = coinModel.priceChangePercentage24H
                let priceStats = StatisticsModel(title: "CurrentPrice", value: price, percentageChange: pricePercentaChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
                let marketCapPercent = coinModel.marketCapChangePercentage24H
                let marketCapStat = StatisticsModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercent)
                
                let rank = "\(coinModel.rank)"
                let rankStat = StatisticsModel(title: "Rank", value: rank)
                
                let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
                let volumeStat = StatisticsModel(title: "Volume", value: volume)
                
                let overviewArray: [StatisticsModel] = [
                    priceStats, marketCapStat, rankStat, volumeStat
                ]
                
                // additional data
                let high = "$" + (coinModel.high24H?.asCurrencyWith6Decimals() ?? "")
                let highStat = StatisticsModel(title: "24h High", value: high)
                
                let low = "$" + (coinModel.low24H?.asCurrencyWith6Decimals() ?? "")
                let lowStat = StatisticsModel(title: "24h Low", value: low)
                
                let priceChange = "$" + (coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "")
                let priceChangePercent = coinModel.priceChangePercentage24H
                let priceChangeStat = StatisticsModel(title: "24h Price Change", value: priceChange, percentageChange: priceChangePercent)
                
                let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
                let marketCapChangePercentage24H = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapChangePercentage24H)
                
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
                let blockStat = StatisticsModel(title: "Block Time", value: blockTimeString)
                
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StatisticsModel(title: "Hashing Algorithm", value: hashing)
                
                let additionalArray: [StatisticsModel] = [
                    highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
                ]
                
                return (overviewArray, additionalArray)
            })
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancelables)
    }
    
}
