//
//  DetailEditView_AnItem.swift
//  My Boxes
//
//  Created by Mirae 

import SwiftUI

struct DetailEditView_AnItem: View {
    
    @Binding var itemData: Box.Item.TagData
    @State private var newKeywordName = ""
    
    var body: some View {
        Form {
            Section(header: Text("아이템 이름")) {
                Text(itemData.itemName)
            }
            Section(header: Text("키워드")) {
                ForEach(itemData.itemTags, id: \.self) { keyword in
                    Text("\(keyword)")
                }
                .onDelete { indices in
                    itemData.itemTags.remove(atOffsets: indices)
                }
                HStack {
                    TextField("새 키워드 추가", text: $newKeywordName)
                    Button(action: {
                        withAnimation {
                            let newKeyword = newKeywordName
                            itemData.itemTags.append(newKeyword)
                            newKeywordName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newKeywordName.isEmpty)
                }
            }
        }
    }
}

struct DetailEditView_AnItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView_AnItem(itemData: .constant(Box.sampleData[0].items[0].tagData))
    }
}
