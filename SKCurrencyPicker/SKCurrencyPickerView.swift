//
//  ContentView.swift
//  CurrencyPicker
//
//  Created by IE14 on 03/05/25.
//

import SwiftUI

public struct SKCurrencyPickerView: View {
    @State var isPresentingCurrencySheet = false
    @StateObject var viewModel = CurrencyViewModel()
    
    public init() { }
    
    public var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack(spacing: 20) {
                    // Show selected currency details
                    Spacer()
                    if let selectedCurrency = viewModel.selectedAllCurrency {
                        VStack (alignment: .leading) {
                            Text("Currency: \(selectedCurrency.name)")
                            Text("Code: \(selectedCurrency.currencyCode)")
                            Text("Symbol: \(selectedCurrency.emoji)")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    } else {
                        Text("No currency selected")
                            .foregroundColor(.secondary)
                    }
                    
                    Button("Select Currency") {
                        isPresentingCurrencySheet = true
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    Spacer()
                    
                }
                .navigationTitle("Selected Currency")
            }
            .sheet(isPresented: $isPresentingCurrencySheet) {
                if let allCountries = viewModel.allCurrency {
                    CurrencyPickerView(
                        allCurrencies: allCountries,
                        selectedCurrency: $viewModel.selectedAllCurrency,
                        isPresent: $isPresentingCurrencySheet
                    )
                }
            }
            .padding()
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    SKCurrencyPickerView()
}
