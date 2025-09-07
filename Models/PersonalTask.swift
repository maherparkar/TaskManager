//
//  PersonalTask.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//


import Foundation

class PersonalTask: Task {
    var notes: String?
}

class WorkTask: Task {
    var project: String?
}

class ShoppingTask: Task {
    var storeName: String?
}
