//
//  BoxesView.swift
//  My Boxes
//
//  Created by Mirae

import SwiftUI

struct BoxesView: View {
    @Binding var boxes: [Box]
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.isSearching) private var isSearching: Bool
    
    @State private var isPresentingNewBoxView = false
    @State private var newBoxData = Box.Data()
    @State private var showFavoritesOnly = false
    @State private var searchText: String = ""
    
    let saveAction: ()->Void
    
    var body: some View {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                // Seperator 추가
                // Box struct를 identifiable 프로토콜을 따르도록 하여 ForEach(boxes, id:\.name)을 단순화함
                ForEach($boxes.filter { $box in !showFavoritesOnly || box.isFavorite }) { $box in
                    // Text(box.name)뷰는 아직 destination 뷰에 디테일이 없기 때문에 사용하는 placeholder -> 디테일 뷰 생성 후 수정
                    NavigationLink(destination: DetailView_itemList(box: $box)) {
                        CardView(box: box)
                    }
                    .listRowSeparatorTint(Color.gray)
                }
                .onDelete { indices in
                    boxes.remove(atOffsets: indices)
                }
            }
            .navigationTitle("보관함")
            .listStyle(.plain)
            .toolbar {
                HStack {
                    Image(systemName: "archivebox.fill")
                    Button(action: {
                        isPresentingNewBoxView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingNewBoxView) {
                NavigationView {
                    DetailEditView(data: $newBoxData)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("취소") {
                                    isPresentingNewBoxView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("추가") {
                                    let newBox = Box(data: newBoxData)
                                    boxes.append(newBox)
                                    // newBox를 비워주어야 함. 박스 하나를 추가하고 완료 후 다시 플러스 버튼을 누르면 방금 추가한 박스의 정보들이 입력된 상태로 추가 뷰가 올라옴.
                                    newBoxData = Box.Data(boxName: "", notes: "", items: [], isFavorite: false)
                                    isPresentingNewBoxView = false
                                }
                                .disabled(newBoxData.boxName.isEmpty)
                            }
                        }
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
            .searchable(text: $searchText)
            .overlay (
                VStack {
                if !isSearching && !searchText.isEmpty {
                    SearchResults(boxes: $boxes, searchText: $searchText)
                }
            }
        )
    }
}


struct BoxesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BoxesView(boxes: .constant(Box.sampleData), saveAction: {})
        }
    }
}
