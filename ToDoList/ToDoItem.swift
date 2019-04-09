//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-09.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation

class ToDoItem {
    let description: String
    let dateCreated: Date
    var completed: Bool
    
    init(description: String) {
        self.description = description
        self.dateCreated = Date()
        self.completed = false
    }
    
    func completeItem() {
        self.completed = true
    }
}
