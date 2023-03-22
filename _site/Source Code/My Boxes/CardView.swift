//
//  CardView.swift
//  My Boxes
//
//  Created by Mirae

import SwiftUI

struct CardView: View {
    let box: Box
    var body: some View {
        VStack {
            HStack {
                if box.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                Text(box.boxName)
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
            HStack {
                Text(box.notes)
                Spacer()
                Text("\(box.items.count)")
                    .padding(.trailing, 20)
                    .foregroundColor(.secondary)
            }
            .font(.body)
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var box = Box.sampleData[0]
    static var previews: some View {
        CardView(box: box)
            .previewLayout(.fixed(width: 400, height: 60))
            .background(Color.init(uiColor: .systemBackground))
    }
}
