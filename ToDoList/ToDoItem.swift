//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-09.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation

class ToDoItem {
    var id: Int64
    let description: String
    let dateCreated: Date
    var completed: Bool
    var dateCompleted: Date?
    
    init(description: String) {
        self.id = 0 // placeholder id, will be updated after db insert
        self.description = description
        self.dateCreated = Date()
        self.completed = false
    }
    
    init(id: Int64, description: String, isCompleted: Bool, dateCreated: Date, dateCompleted: Date?) {
        self.id = id
        self.description = description
        self.dateCreated = dateCreated
        self.completed = isCompleted
        self.dateCompleted = dateCompleted
    }
    
    // set id with value from db after it's added
    func setId(id: Int64) {
        self.id = id
    }
    
    func toggleComplete() {
        // if it's already complete set date to nil else to now
        self.dateCompleted = self.completed ? nil : Date()
        
        // switch to opposite state of current
        self.completed = !self.completed
    }
    
    // return the formatted date or "" if it's not completed yet
    func dateCompletedAsString() -> String {
        return self.dateCompleted == nil ? "" : dateAsString(date: self.dateCompleted!)
    }
    
    // return the formatted created date
    func dateCreatedAsString() -> String {
        return dateAsString(date: self.dateCreated)
    }
    
    // return a formatted date
    func dateAsString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "MMM dd, YYYY - h:mm a"
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: date)
    }
}
