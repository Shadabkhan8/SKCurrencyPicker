//
//  ContentView.swift
//  CurrencyPicker
//
//  Created by IE14 on 03/05/25.
//

import SwiftUI

public struct SKCurrencyPickerView: View {
    @State private var isPresentingCurrencySheet = false
    @StateObject private var viewModel = CurrencyViewModel()
    
    public init() {}

    public var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                if let selectedCurrency = viewModel.selectedAllCurrency {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 16) {
                            Text(selectedCurrency.emoji)
                                .font(.system(size: 48))
                            
                            VStack(alignment: .leading) {
                                Text(selectedCurrency.name)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Text("Code: \(selectedCurrency.currencyCode)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Divider()
                        
                        Text("Symbol: \(selectedCurrency.emoji)")
                            .font(.headline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    .padding(.horizontal)
                } else {
                    Text("No currency selected")
                        .foregroundColor(.secondary)
                        .padding()
                }

                Spacer()
                
                Button(action: {
                    isPresentingCurrencySheet = true
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Select Currency")
                            .fontWeight(.bold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarTitle("Currency Picker", displayMode: .inline)
            .sheet(isPresented: $isPresentingCurrencySheet) {
                if let allCountries = viewModel.allCurrency {
                    CurrencyPickerView(
                        allCurrencies: allCountries,
                        selectedCurrency: $viewModel.selectedAllCurrency,
                        isPresent: $isPresentingCurrencySheet
                    )
                } else {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemBackground))
                }
            }
        }
    }
}

#Preview {
    SKCurrencyPickerView()
}
