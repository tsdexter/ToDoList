//
//  ToDoListManager.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-18.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation

class ToDoListManager {
    
    var data: [ToDoItem]
    
    init() {
        // use different data for testing
        let item1: ToDoItem = ToDoItem(description: "Item 1")
        let item2: ToDoItem = ToDoItem(description: "Item 2")
        let item3: ToDoItem = ToDoItem(description: "Item 3")
        item2.toggleComplete()
        
        self.data = [item1, item2, item3]
    }
    
    func getItems() -> [ToDoItem] {
        return self.data
    }
    
    func count() -> Int {
        return self.getItems().count
    }
    
    func addItem(item: ToDoItem) {
        self.data.append(item)
    }
}
