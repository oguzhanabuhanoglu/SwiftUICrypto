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
            
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 15){
                    overviewTitle
                    Divider()
                    overViewGrid
                    
                    additionalTitle
                    Divider()
                    additionalGrid
                }
                .padding()
            }
        }
        .navigationTitle("\(vm.coin.name)")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
            }
        }
            
        
        
        
    }
    
}

#Preview {
    // i couldn not see the navigation tittle because of preview is not in a navigation view
    NavigationView(content: {
        DetailsView(coin: DeveloperPreview.instance.coin)
    })
    
}


extension DetailsView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: 30,
                  pinnedViews: [],
                  content: {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var additionalTitle: some View {
        Text("Additional")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: 30,
                  pinnedViews: [],
                  content: {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var navigationBarTrailingItem: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
}
