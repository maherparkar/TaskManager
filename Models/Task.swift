//
//  Task.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//


import Foundation

class Task: TaskProtocol {
    var id = UUID()
    var title: String
    var dueDate: Date
    var isCompleted: Bool = false
    
    init(title: String, dueDate: Date) {
        self.title = title
        self.dueDate = dueDate
    }
}
