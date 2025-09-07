//
//  WorkTask.swift
//  task_manager
//
//  Created by Maher Parkar on 8/9/2025.
//


import Foundation

class WorkTask: Task {
    var project: String?
    
    init(title: String, dueDate: Date, project: String? = nil) {
        self.project = project
        super.init(title: title, dueDate: dueDate, type: .work)
    }
}
