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
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    // To get api call resutls from data service
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
        //this was for mock coin
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
         self.allCoins.append(DeveloperPreview.instance.coin)
         self.portfolioCoins.append(DeveloperPreview.instance.coin)
         }
         */
    }
    
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            // hızlı işlemler için 0.5 saniye es verip kodun sonrasını ona göre çalıştıracak
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text, startingCoins) -> [CoinModel] in
                filteredCoins(text: text, startingCoins: startingCoins)
            }
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
        .store(in: &cancellables)    }
    
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

