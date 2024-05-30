//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 13.05.2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var showPortfolio: Bool = false
    @State private var showEditPortfolioView: Bool = false
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailsView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            // background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showEditPortfolioView, content: {
                    EditPortfolioView()
                })
            
            //content layer
            VStack{
                
                headerView
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBar(searchText: $vm.searchText)
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }else{
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
            }
            .background(
                NavigationLink(
                    destination: DetailLoadingView(coin: $selectedCoin),
                    isActive: $showDetailsView,
                    label: { EmptyView() })
            )
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

extension HomeView {
    
    private var headerView: some View {
        HStack{
            
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showEditPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimation(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
    }
    
    
    private var columnTitles: some View {
        HStack{
            
            HStack {
                Text("Coins")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .rank || vm.sortOptions == .reversedRank) ? 1.0 : 0.3)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .rank ? 0 : 180))
            }
            .onTapGesture {
                vm.sortOptions = vm.sortOptions == .rank ? .reversedRank : .rank
                /*if vm.sortOptions == .rank {
                    vm.sortOptions = .reversedRank
                }else{
                    vm.sortOptions = .rank
                }*/
            }
            Spacer()
            
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOptions == .holdings || vm.sortOptions == .reversedHoldings) ? 1.0 : 0.3)
                        .rotationEffect(Angle(degrees: vm.sortOptions == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    vm.sortOptions = vm.sortOptions == .holdings ? .reversedHoldings : .holdings
                }
            }
            
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .reversedRank) ? 1.0 : 0.3)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                vm.sortOptions = vm.sortOptions == .price ? .reversedPrice : .price
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    
    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailsView.toggle()
    }
}
