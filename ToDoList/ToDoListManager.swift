//
//  ToDoListManager.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-18.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation

class ToDoListManager {
    
    let databaseHelper: DatabaseHelper
    
    init() {
        databaseHelper = DatabaseHelper()
    }
    
    func getItems() -> [ToDoItem] {
        return self.databaseHelper.getItems() ?? [ToDoItem]()
    }
    
    func count() -> Int {
        return self.getItems().count
    }
    
    func addItem(item: ToDoItem) {
        self.databaseHelper.insertItem(item: item)
    }
}
