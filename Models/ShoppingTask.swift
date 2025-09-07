//
//  ShoppingTask.swift
//  task_manager
//
//  Created by Maher Parkar on 8/9/2025.
//

import Foundation

class ShoppingTask: Task {
    var storeName: String?
    
    init(title: String, dueDate: Date, storeName: String? = nil) {
        self.storeName = storeName
        super.init(title: title, dueDate: dueDate, type: .shopping)
    }
}
