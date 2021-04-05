//
//  String+.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

extension String {
    var formattedCurrency: String {
        let value = Double(self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 20
        return formatter.string(from: value! as NSNumber) ?? "0"
    }
}
