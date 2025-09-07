//
//  AddTaskView.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//


import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    @State private var title = ""
    @State private var dueDate = Date()
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.addTask(title: title, dueDate: dueDate)
                            dismiss()
                        } catch {
                            errorMessage = error.localizedDescription
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
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

