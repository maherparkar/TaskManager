//
//  TaskProtocol.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//


import Foundation

protocol TaskProtocol: Identifiable {
    var id: UUID { get }
    var title: String { get set }
    var dueDate: Date { get set }
    var isCompleted: Bool { get set }
    
    func isOverdue() -> Bool
    func markCompleted()
}
