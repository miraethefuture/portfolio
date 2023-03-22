//
//  DetailEditView.swift
//  My Boxes
//
//  Created by Mirae

import SwiftUI

struct DetailEditView: View {
    @Binding var data: Box.Data
    @State private var newItemName = ""

    var body: some View {
        Form {
            Section(header: Text("보관함")) {
                TextField("보관함 이름", text: $data.boxName)
                TextField("보관함 설명", text: $data.notes)
            }
            Section(header: Text("아이템 목록")) {
                ForEach(data.items) { item in
                    Text(item.itemName)
                }
                .onDelete { indices in
                    data.items.remove(atOffsets: indices)
                }
                HStack {
                    TextField("새 아이템 추가", text: $newItemName)
                    Button(action: {
                        withAnimation {
                            let newItem = Box.Item(itemName: newItemName)
                            data.items.append(newItem)
                            newItemName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newItemName.isEmpty) // 사용자가 이름없이 아이템을 저장하는 것을 방지
                }
            }
        }
    }
}



struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(Box.sampleData[0].data))
    }
}
