//
//  TaskListView.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//


import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    TaskRowView(task: task, toggle: {
                        viewModel.toggleCompletion(task: task)
                    })
                }
                .onDelete(perform: viewModel.deleteTask)
            }
            .navigationTitle("My Tasks")
            .toolbar {
                Button(action: { showingAddTask.toggle() }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
        .alert("Error", isPresented: Binding<Bool>(
            get: { errorMessage != nil },
            set: { if !$0 { errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) { errorMessage = nil }
        } message: {
            Text(errorMessage ?? "")
        }

    }
}
