//
//  DatabaseHelper.swift
//  ToDoList
//
//  Created by Thomas Dexter on 2019-04-18.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    let db: Connection?
    let items = Table("items")
    let id = Expression<Int64>("id")
    let description = Expression<String>("description")
    let isCompleted = Expression<Bool>("isCompleted")
    let dateAdded = Expression<Date>("dateAdded")
    
    init() {
    
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/itemsDb.sqlite3")
            print(path)
            createItemsTable()
        } catch (let message) {
            print(message)
            db = nil
        }
        
    }
    
    private func createItemsTable() {
        if (db == nil) {
            print("unable to get connection")
            return
        }
        
        do {
            try db!.run(items.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(description)
                t.column(isCompleted, defaultValue: false)
                t.column(dateAdded)
            })
        } catch (let message) {
            print(message)
        }
    }
    
    func insertItem(item: ToDoItem) {
        if (db == nil) {
            print("Unable to get connection")
            return
        }
        
        let insert = items.insert(
            description <- item.description,
            isCompleted <- item.completed,
            dateAdded <- item.dateCreated
        )
        
        do {
            try db!.run(insert)
        } catch (let message) {
            print(message)
        }
    }
    
    func getItems() -> [ToDoItem]? {
        if (db == nil) {
            print("Unable to get connection")
            return nil
        }
        
        do {
            
            var toDoItems: [ToDoItem] = [ToDoItem]()
            
            for row in try db!.prepare(items) {
                let item = ToDoItem(
                    description: row[description],
                    isCompleted: row[isCompleted],
                    dateCreated: row[dateAdded]
                )
                toDoItems.append(item)
            }
            
            return toDoItems
            
        } catch (let message) {
            print(message)
            return nil
        }
    }
}
