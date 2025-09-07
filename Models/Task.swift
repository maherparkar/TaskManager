//
//  Task.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//

import Foundation

// MARK: - Task Types
enum TaskType: String, CaseIterable, Codable {
    case personal = "Personal"
    case work = "Work"
    case shopping = "Shopping"
}

// MARK: - Base Task
class Task: TaskProtocol {
    var id = UUID()
    var title: String
    var dueDate: Date
    var isCompleted: Bool = false
    var type: TaskType
    
    init(title: String, dueDate: Date, type: TaskType) {
        self.title = title
        self.dueDate = dueDate
        self.type = type
    }
    
    func isOverdue() -> Bool {
        return !isCompleted && dueDate < Date()
    }
    
    func markCompleted() {
        isCompleted = true
    }
}


