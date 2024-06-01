//
//  String.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 1.06.2024.
//

import Foundation

extension String {
    
    // to remove HTML string of descriotion text
    var removinHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^<]+>", with: "", options: .regularExpression, range: nil)
    }
}
