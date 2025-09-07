//
//  TaskViewModel.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//


import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []   // Published so SwiftUI updates automatically
    
    // Add a new task
    func addTask(title: String, dueDate: Date) throws {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw TaskError.invalidTitle
        }
        let newTask = Task(title: title, dueDate: dueDate)
        tasks.append(newTask)
    }
    
    // Delete task at index
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // Toggle completion state
    func toggleCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}

// Custom Error Handling
enum TaskError: Error, LocalizedError, Identifiable {
    case invalidTitle
    
    var id: String {
        self.localizedDescription
    }
    
    var errorDescription: String? {
        switch self {
        case .invalidTitle:
            return "Task title cannot be empty."
        }
    }
}
