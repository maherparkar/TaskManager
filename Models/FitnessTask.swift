//
//  FitnessTask.swift
//  task_manager
//
//  Created by Maher Parkar on 8/9/2025.
//


import Foundation

class FitnessTask: Task {
    init(title: String, dueDate: Date) {
        super.init(title: title, dueDate: dueDate, type: .fitness)
    }
}
