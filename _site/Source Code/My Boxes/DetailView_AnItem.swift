//
//  DetailView_AnItem.swift
//  My Boxes
//
//  Created by Mirae
//  각 아이템의 상세 정보를 보여주는 화면

import SwiftUI

struct DetailView_AnItem: View {
    
    @Binding var item: Box.Item
    
    @State private var itemData = Box.Item.TagData()
    @State private var newTagName = ""
    @State private var isPresentingEditItemView = false
    
    var body: some View {
        List {
            Section(header: Text("아이템 이름")) {
                TextField("아이템 이름", text: $item.itemName)
            }
            Section(header: Text("검색 키워드")) {
                ForEach($item.itemTags, id: \.self) { $tag in
                    Text("\(tag)")
                }
            }
        }
        .navigationTitle(item.itemName)
        .listStyle(.plain)
        .toolbar {
            Button("Edit") {
                isPresentingEditItemView = true
                itemData = item.tagData
            }
        }
        .fullScreenCover(isPresented: $isPresentingEditItemView) {
            NavigationView {
                DetailEditView_AnItem(itemData: $itemData)
                    .navigationTitle(item.itemName)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditItemView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditItemView = false
                                item.updateTags(from: itemData)
                            }
                            
                        }
                    }
            }
        }
    }
}


struct DetailView_AnItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailView_AnItem(item: .constant(Box.sampleData[0].items[1]))
    }
}
