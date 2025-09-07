import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var errorMessage: ErrorMessage?
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - Active Tasks
                Section(header: Text("My Tasks")) {
                    let activeTasks = viewModel.tasks.filter { !$0.isCompleted }
                    
                    if activeTasks.isEmpty {
                        Text("No pending tasks 🎉")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(activeTasks) { task in
                            TaskRowView(task: task) {
                                viewModel.toggleCompletion(task: task)
                            }
                        }
                        .onDelete { offsets in
                            let activeTasks = viewModel.tasks.filter { !$0.isCompleted }
                            let idsToDelete = offsets.map { activeTasks[$0].id }
                            viewModel.tasks.removeAll { idsToDelete.contains($0.id) }
                        }
                    }
                }
                
                // MARK: - Completed Tasks
                Section(
                    header: HStack {
                        Text("Completed Tasks")
                        Spacer()
                        if viewModel.tasks.contains(where: { $0.isCompleted }) {
                            Button("Clear All") {
                                viewModel.clearCompleted()
                            }
                            .font(.caption)
                            .foregroundColor(.red)
                        }
                    }
                ) {
                    let completedTasks = viewModel.tasks.filter { $0.isCompleted }
                    
                    if completedTasks.isEmpty {
                        Text("No completed tasks yet")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(completedTasks) { task in
                            TaskRowView(task: task) {
                                viewModel.toggleCompletion(task: task)
                            }
                        }
                        .onDelete { offsets in
                            let completedTasks = viewModel.tasks.filter { $0.isCompleted }
                            let idsToDelete = offsets.map { completedTasks[$0].id }
                            viewModel.tasks.removeAll { idsToDelete.contains($0.id) }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Task Manager")
            .toolbar {
                // ✅ Left → Mark All button
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.tasks.contains(where: { !$0.isCompleted }) {
                        Button("Mark All") {
                            viewModel.markAllAsComplete()
                        }
                    }
                }
                // ✅ Right → Add Task button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
            .alert(item: $errorMessage) { msg in
                Alert(
                    title: Text("Error"),
                    message: Text(msg.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

