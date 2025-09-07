//
//  EditTaskView.swift
//  task_manager
//
//  Created by Maher Parkar on 8/9/2025.
//


import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State var task: Task
    @State private var newTitle: String
    @State private var newDate: Date
    
    init(viewModel: TaskViewModel, task: Task) {
        self.viewModel = viewModel
        _task = State(initialValue: task)
        _newTitle = State(initialValue: task.title)
        _newDate = State(initialValue: task.dueDate)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $newTitle)
                DatePicker("Due Date", selection: $newDate, displayedComponents: .date)
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                            viewModel.tasks[index].title = newTitle
                            viewModel.tasks[index].dueDate = newDate
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
