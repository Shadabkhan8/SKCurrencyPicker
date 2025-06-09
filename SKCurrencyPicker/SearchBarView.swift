//
//  SearchBarView.swift
//  CurrencyPicker
//
//  Created by IE14 on 03/05/25.
//

import SwiftUI

public struct SearchBarView: View {
    @Binding var value: String
    let isAnimating: Bool
    var color: Color = .white

    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            if #available(iOS 15.0, *) {
                TextField("Search currencies...", text: $value)
                    .disabled(isAnimating)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.characters)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
            } else {
                // Fallback on earlier versions
            }

            if isAnimating {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.trailing, 4)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}
