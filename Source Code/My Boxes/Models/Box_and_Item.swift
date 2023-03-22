//
//  Box.swift
//  My Boxes
//
//  Created by Mirae

import Foundation

struct Box: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var boxName: String
    var notes: String
    var items: [Item]
    var isFavorite: Bool
    
    
    init(id: UUID = UUID(), boxName: String, notes: String, items: [Item], isFavorite: Bool) {
        self.id = id
        self.boxName = boxName
        self.notes = notes
        self.items = items
        self.isFavorite = isFavorite
    }
}

extension Box {
    struct Item: Identifiable, Codable, Equatable, Hashable {
        var id: UUID = UUID()
        var itemName: String = ""
        var itemTags: [String] = []

        
        init(id: UUID = UUID(), itemName: String, itemTags: [String]) {
            self.id = id
            self.itemName = itemName
            self.itemTags = itemTags
        }
        
        init(id: UUID = UUID(), itemName: String) {
            self.id = id
            self.itemName = itemName
        }
        
        struct TagData {
            var itemName: String = ""
            var itemTags: [String] = []
        }
        
        var tagData: TagData {
            TagData(itemName: itemName, itemTags: itemTags)
        }
        
        
        init(tagData: TagData) {
            id = UUID()
            itemName = tagData.itemName
            itemTags = tagData.itemTags
        }
        
        mutating func updateTags(from tagData: TagData) {
            itemName = tagData.itemName
            itemTags = tagData.itemTags
        }
        
        
        init(id: UUID = UUID(), itemTags: String) {
            self.id = id
            self.itemTags.append(itemTags)
        }
    }
    
    struct Data {
        var boxName: String = ""
        var notes: String = ""
        var items: [Item] = []
        var isFavorite: Bool = false
    }
    
    var data: Data {
        Data(boxName: boxName, notes: notes, items: items, isFavorite: isFavorite)
    }
    
    mutating func update(from data: Data) {
        boxName = data.boxName
        notes = data.notes
        items = data.items
        isFavorite = data.isFavorite // 필요한지 확인
    }
    
    init(data: Data) {
        id = UUID()
        boxName = data.boxName
        notes = data.notes
        items = data.items
        isFavorite = data.isFavorite
    }
}

extension Box {
    static let sampleData: [Box] =
    [
        Box(boxName: "옷장",
            notes: "옷 보관",
            items: [
                Item(itemName: "검정 폴라티", itemTags: ["가을옷", "겨울옷"]),
                Item(itemName: "베이지 트렌치 코트", itemTags: ["가을옷"]),
                Item(itemName: "카키 자켓", itemTags: ["가을옷"])
            ],
            isFavorite: false
           ),
        Box(boxName: "흰색 컨테이너",
            notes: "옷 보관",
            items: [
                Item(itemName: "브라운 폴라티", itemTags: ["가을옷", "겨울옷"]),
                Item(itemName: "자주색 가디건", itemTags: ["가을옷"])
            ],
            isFavorite: false
           ),
        Box(boxName: "신발장",
            notes: "신발 보관",
            items: [
                Item(itemName: "가죽 샌달", itemTags: ["여름용", "샌달"]),
                Item(itemName: "검정 부츠", itemTags: ["검정", "부츠", "겨울용"]),
                Item(itemName: "슬립온", itemTags: ["체커보드", "슬립온", "봄여름가을용"])
            ],
            isFavorite: true
           ),
    ]
}
