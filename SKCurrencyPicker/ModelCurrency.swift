//
//  Country.swift
//  RBCountryPickerView
//
//  Created by IE14 on 27/03/25.
//

import Foundation
public class SKCurrencyPickerResourceFinder: NSObject {}

public struct ModelCurrency: Codable, Hashable, Identifiable {
    public var id: String {
        currencyCode
    }
    public var name: String
    public var currencyCode: String
    public var emoji: String
    
    enum CodingKeys: String, CodingKey {
        case name = "currency_name"
        case currencyCode = "currency"
        case emoji
    }
    
}
