//
//  ChartView.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 31.05.2024.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = ((data.last ?? 0) - (data.first ?? 0))
        lineColor = priceChange >= 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(dateStrinFromAPI: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            charView
                .frame(height: 200)
                .background (backgroundView)
                .overlay(chartPriceLabels.padding(.horizontal, 4), alignment: .leading)
            chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
    // math logics for chart line
    /*
     widht = 399
     data.count = 100
     3 for per data
     100 * 3 = 300
    
     data.max() = 60000
     data.min() = 50000
     yAxis = 60000 - 50000 = 10000
     if currentDataPoint = 52000
     52000 - 50000 => 2000 / yaxis = %20 from bottom
     */
    private var charView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                
                    // index sıfırdan başlayacağı için index + 1 çarpası yapıldı
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
            
        }
    }
    
    private var backgroundView: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartPriceLabels: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortFormatter())
            Spacer()
            Text(endingDate.asShortFormatter())
        }
    }
}
