//
//  DetailView_itemList.swift
//  My Boxes
//
//  Created by Mirae

import SwiftUI

struct DetailView_itemList: View {
    @Binding var box: Box
    @State private var data = Box.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        Text("\(box.notes)")
                        Spacer()
                        FavoriteButton(isSet: $box.isFavorite)
                    }
                }
            }
            .foregroundColor(.secondary)
            .listRowSeparator(.hidden)
            .padding()
            Section(header: Text("아이템 목록")) {
                ForEach($box.items) { $item in
                    NavigationLink(destination: DetailView_AnItem(item: $item)) {
                        Text("\(item.itemName)")
                    }
                }
                .onMove { (IndexSet, index) in
                    box.items.move(fromOffsets: IndexSet, toOffset: index)
                }
                .environment(\.editMode, Binding.constant(EditMode.active))
            }
        }
        .navigationTitle(box.boxName)
        .listStyle(.plain)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                // 바인딩 data 가 Box의 computed property인 data를 사용해서 생성한 인스턴스를 담게 됨
                data = box.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(box.boxName)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                box.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}


struct DetailView_itemList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView_itemList(box: .constant(Box.sampleData[0]))
        }
    }
}
