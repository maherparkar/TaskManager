//
//  FinanceTask.swift
//  task_manager
//
//  Created by Maher Parkar on 8/9/2025.
//


import Foundation

class FinanceTask: Task {
    init(title: String, dueDate: Date) {
        super.init(title: title, dueDate: dueDate, type: .finance)
    }
}
