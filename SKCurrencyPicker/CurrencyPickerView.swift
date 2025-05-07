//
//  CurrencyPickerView.swift
//  CurrencyPicker
//
//  Created by IE14 on 03/05/25.
//

import SwiftUI

public struct CurrencyPickerView: View {
    
    let allCurrencies: [ModelCurrency]
    @Binding var selectedCurrency: ModelCurrency?
    @Binding var isPresent: Bool
    @State var searchCurrency: String = ""
    @State var searchBarLoader: Bool = false
    @State var filteredCurrency: [ModelCurrency]?
    
    public init(allCurrencies: [ModelCurrency], selectedCurrency: Binding<ModelCurrency?> = .constant(nil), isPresent: Binding<Bool>, filteredCurrency: [ModelCurrency]? = nil) {
        self.allCurrencies = allCurrencies
        self._selectedCurrency = selectedCurrency
        self._isPresent = isPresent
        self.filteredCurrency = allCurrencies
    }

    public var body: some View {
        VStack(spacing: 16) {
            Text("Select a currency")
                .foregroundColor(Color.black)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .padding(.top, 30)
            
            SearchBarView(value: $searchCurrency, isAnimating: searchBarLoader, color: .white)
                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 140 : 100)
                .padding(.horizontal, -8)
            
            
            ScrollView {
                ForEach(filteredCurrency ?? allCurrencies, id: \.id) { currency in
                    Button {
                        selectedCurrency = currency
                        isPresent = false
                    } label: {
                        CountryPickerViewCell(cellTitle: currency.name, cellImage: currency.emoji, cellSubtitle: currency.currencyCode)
                            .padding(.horizontal, 24)
                    }
                }
            }
        }
        .onChange(of: searchCurrency) { newValue in
            filteredCurrency = filterCurrency()
        }

    }

    
    public func filterCurrency() -> [ModelCurrency] {
        if searchCurrency.isEmpty {
            return deduplicateCurrencies(allCurrencies)
        } else {
            let query = searchCurrency.lowercased()
            let filtered = allCurrencies.filter { currency in
                currency.name.lowercased().contains(query) ||
                currency.currencyCode.lowercased().contains(query)
            }
            return deduplicateCurrencies(filtered)
        }
    }

    public func deduplicateCurrencies(_ currencies: [ModelCurrency]) -> [ModelCurrency] {
        var seen = Set<String>()
        var uniqueCurrencies: [ModelCurrency] = []

        for currency in currencies {
            let key = "\(currency.name.lowercased())_\(currency.currencyCode.lowercased())"
            if !seen.contains(key) {
                seen.insert(key)
                uniqueCurrencies.append(currency)
            }
        }
        return uniqueCurrencies
    }
}
