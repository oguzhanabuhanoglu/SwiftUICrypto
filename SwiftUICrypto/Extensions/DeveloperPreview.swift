//
//  PreviewProvider.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 24.05.2024.
//

import Foundation
import SwiftUI

// Artık preview yapısı doğrudan PreviewProvider protokolunu kullanmıyor.Preview içinden doğrudan instance a ulaşılabilir 
/*
extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}
*/

//sinleton yapısı
class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init(){}
    
    let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 69514,
        marketCap: 1371363569575,
        marketCapRank: 1,
        fullyDilutedValuation: 1461716142236,
        totalVolume: 30265418388,
        high24H: 70585,
        low24H: 69212,
        priceChange24H: -83.99609802513442,
        priceChangePercentage24H: -0.12069,
        marketCapChange24H: -3272239310.4523926,
        marketCapChangePercentage24H: -0.23804,
        circulatingSupply: 19701934,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 73738,
        athChangePercentage: -5.72775,
        athDate: "2024-03-14T07:10:36.635Z",
        atl: 67.81,
        atlChangePercentage: 102415.02486,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2024-05-22T18:20:21.340Z",
        sparklineIn7D: SparklineIn7D(
            price: [
                    65119.01172188584,
                    64680.82190015689,
                    65106.89335977176,
                    65204.88427248887,
                    65102.87199878442,
                    64336.89995944808,
                    63570.89173995238,
                    62658.017158204675,
                    62957.281376867075,
                    62858.953894481885,
                    62921.062761175956,
                    61951.93950261966,
                    62406.80428086265,
                    62655.46824206328,
                    61973.976908080695,
                    61246.714358891346,
                    60521.8211236715,
                    59978.184488110805,
                    59765.31913555916,
                    59413.23666352234,
                    58850.0803738194,
                    58767.85971590297,
                    57977.10050688103,
                    57415.31747968385,
                    56964.86024462439,
                    56648.96522094994,
                    56826.72916303946,
                    56126.239836277,
                    55897.591493897424,
                    55786.21334719049,
                    54855.88896627048,
                    54767.20624412264,
                    54022.992429653576,
                    53120.569819131495,
                    53543.898125011496,
                    53992.34617462334,
                 
                
            ]
        ),
        priceChangePercentage24HInCurrency: 1.0130162057009557,
        currentHoldings: 1.5
       )
    
    let stat1 = StatisticsModel(title: "Market Cap", value: "$12.56Bn", percentageChange: 24.42 )
    let stat2 = StatisticsModel(title: "Total Volume", value: "1.23Tr")
    let stat3 = StatisticsModel(title: "Market Cap", value: "$12.56Bn", percentageChange: -14.42 )
    
}
