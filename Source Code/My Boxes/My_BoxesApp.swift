//
//  My_BoxesApp.swift
//  My Boxes
//
//  Created by Mirae

import SwiftUI

@main
struct My_BoxesApp: App {
    @StateObject private var store = BoxStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                BoxesView(boxes: $store.boxes) {
                    BoxStore.save(boxes: store.boxes) { result in
                        if case .failure(let error) = result {
                            debugPrint(error) // fatalError(error.localizedDescription)가 에러가 나서 수정
                        }
                    }
                }
            }
            .onAppear {
                BoxStore.load { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error) // fatalError(error.localizedDescription)가 에러가 나서 수정
                    case .success(let boxes):
                        store.boxes = boxes
                    }
                }
            }
        }
    }
}
