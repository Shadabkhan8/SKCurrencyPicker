//
//  CurrencyViewModel.swift
//  CurrencyPicker
//
//  Created by IE14 on 03/05/25.
//

import Combine
import Foundation
import SwiftUI

public class CurrencyViewModel: ObservableObject {
    
    @Published var allCurrency: [ModelCurrency]?
    @Published var selectedAllCurrency: ModelCurrency?
    @Published var presentStatePickerView: Bool = false
    @Published var checkInDate = Date()
    
    @Published var showToast: Bool = false
    var toastMessage: String = ""
    
    let minimumDate: PartialRangeThrough<Date>
    
    public init(minAge: Int = 18) {
        let minimumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        self.minimumDate = ...minimumDate!
        fetchCountryData()
    }
    
    public func fetchCountryData() {
        let bundle = Bundle(for: SKCurrencyPickerResourceFinder.self)

        if let url = bundle.url(forResource: "countries+states", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let currencyData = try decoder.decode([ModelCurrency].self, from: data)
                allCurrency = currencyData
            } catch {
                print(" Error decoding JSON: \(error)")
            }
        } else {
            print(" countries+states.json not found in bundle")
        }
    }

    public func showAlert(message: String) {
        toastMessage = message
        showToast.toggle()
    }
}
