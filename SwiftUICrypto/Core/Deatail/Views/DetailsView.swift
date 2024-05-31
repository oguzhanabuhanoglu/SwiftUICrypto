//
//  DetailsView.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 31.05.2024.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailsView(coin: coin)
            }
        }
    }
}

struct DetailsView: View {
    
    @StateObject var vm: CoinDetailViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("Initiazing Detail View for \(coin.name)")
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 10){
                Text("space for graphic")
                    .frame(height: 150)
                
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(columns: columns,
                          alignment: .leading,
                          spacing: nil,
                          pinnedViews: [],
                          content: {
                    ForEach(0..<4) { _ in
                        StatisticView(stat: StatisticsModel(title: "Title", value: "Value"))
                    }
                })
                
                Text("Additional")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                
                LazyVGrid(columns: columns,
                          alignment: .leading,
                          spacing: nil,
                          pinnedViews: [],
                          content: {
                    ForEach(0..<6) { _ in
                        StatisticView(stat: StatisticsModel(title: "Title", value: "Value"))
                    }
                })
                
            }
            .padding()
        }
        .navigationTitle("\(vm.coin.name)")
        
        
    }
    
}

#Preview {
    // i couldn not see the navigation tittle because of preview is not in a navigation view
    NavigationView(content: {
        DetailsView(coin: DeveloperPreview.instance.coin)
    })
    
}
