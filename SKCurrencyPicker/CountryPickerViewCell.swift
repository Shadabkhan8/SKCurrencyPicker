//
//  CountryPickerViewCell.swift
//  CurrencyPicker
//
//  Created by IE14 on 03/05/25.
//

import SwiftUI

public struct CountryPickerViewCell: View {
    let cellTitle: String
    let cellImage: String?
    let cellSubtitle: String?

    public init(cellTitle: String, cellImage: String? = nil, cellSubtitle: String? = nil) {
        self.cellTitle = cellTitle
        self.cellImage = cellImage
        self.cellSubtitle = cellSubtitle
    }

    public var body: some View {
        ZStack {
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .background(
                        LinearGradient(
                            colors: [Color.white.opacity(0.4), Color.blue.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)
            } else {
            }

            HStack(spacing: 16) {
                if let emoji = cellImage {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)], startPoint: .top, endPoint: .bottom))
                            .frame(width: 48, height: 48)

                        Text(emoji)
                            .font(.system(size: 40))
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(cellTitle)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)

                    if let subtitle = cellSubtitle {
                        Text(subtitle)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 16)
        }
        .padding(.vertical, 6)
    }
}
