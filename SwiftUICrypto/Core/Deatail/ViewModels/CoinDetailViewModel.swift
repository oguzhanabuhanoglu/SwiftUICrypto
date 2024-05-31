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
                <#code#>
            })
            .sink { (returnedArrays) in
                print(returnedArrays.overview)
                print(returnedArrays.additional)
            }
            .store(in: &cancelables)
    }
    
}
