//
//  Date.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 1.06.2024.
//

import Foundation

extension Date {
    
    // "2024-05-22T18:20:21.340Z"
    init(dateStrinFromAPI: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: dateStrinFromAPI) ?? Date()
        self.init(timeInterval: 0, since: date)
        
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortFormatter() -> String {
        return shortFormatter.string(from: self)
    }
}
