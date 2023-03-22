//
//  SearchResult.swift
//  My Boxes
//
//  Created by Mirae

import SwiftUI

struct SearchResults: View {
    @State private var filteredItems: [Box.Item] = []
    
    @Binding var boxes: [Box]
    @Binding var searchText: String
    
    var body: some View {
        Form {
            ForEach($boxes) { $box in
                ForEach(box.items.filter { $0.itemName.localizedCaseInsensitiveContains(searchText) || $0.itemTags.contains(searchText) }) { item in
                    NavigationLink(destination: DetailView_itemList(box: $box)) {
                        Text(item.itemName)
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
}



struct SearchResult_Previews: PreviewProvider {
    static var previews: some View {
        SearchResults(boxes: .constant(Box.sampleData), searchText: .constant("검정"))
    }
}
