import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var showingEditTask: Task? = nil
    @State private var errorMessage: ErrorMessage?
    
    //  Selected filter (default = All)
    @State private var selectedFilter: TaskType? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // Filter Bar
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        filterButton(label: "All", type: nil, color: .blue)
                        
                        ForEach(TaskType.allCases, id: \.self) { type in
                            filterButton(label: type.rawValue, type: type, color: typeColor(for: type))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                
                // MARK: - Task Sections
                ScrollView {
                    VStack(spacing: 28) {
                        
                        // Active Tasks
                        taskSection(
                            title: "My Tasks",
                            tasks: viewModel.tasks.filter { !$0.isCompleted },
                            emptyText: "No pending tasks 🎉"
                        )
                        
                        // Completed Tasks
                        taskSection(
                            title: "Completed Tasks",
                            tasks: viewModel.tasks.filter { $0.isCompleted },
                            emptyText: "No completed tasks yet",
                            allowClear: true
                        )
                    }
                    .padding(.vertical)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Task Manager")
            .toolbar {
                // Left → Mark All button
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.tasks.contains(where: { !$0.isCompleted }) {
                        Button("Mark All") {
                            viewModel.markAllAsComplete()
                        }
                    }
                }
                // Right → Add Task button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                    .accessibilityIdentifier("AddTaskButton")
                }
            }
            // Add Task
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
            // Edit Task
            .sheet(item: $showingEditTask) { task in
                EditTaskView(viewModel: viewModel, task: task)
            }
            // Error Alerts
            .alert(item: $errorMessage) { msg in
                Alert(
                    title: Text("Error"),
                    message: Text(msg.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // Filter Button Builder
    private func filterButton(label: String, type: TaskType?, color: Color) -> some View {
        Button(action: { selectedFilter = type }) {
            Text(label)
                .fontWeight(selectedFilter == type ? .bold : .regular)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(selectedFilter == type ? color.opacity(0.2) : Color(.systemGray5))
                .foregroundColor(color)
                .cornerRadius(20)
        }
    }
    
    // Task Section Builder
    @ViewBuilder
    private func taskSection(title: String, tasks: [Task], emptyText: String, allowClear: Bool = false) -> some View {
        let filteredTasks = selectedFilter == nil ? tasks : tasks.filter { $0.type == selectedFilter }
        
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                if allowClear && tasks.contains(where: { $0.isCompleted }) {
                    Button("Clear All") {
                        viewModel.clearCompleted()
                    }
                    .font(.caption)
                    .foregroundColor(.red)
                }
            }
            .padding(.horizontal)
            
            if filteredTasks.isEmpty {
                Text(emptyText)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
            } else {
                ForEach(filteredTasks) { task in
                    TaskRowView(
                        task: task,
                        toggle: { viewModel.toggleCompletion(task: task) },
                        onDelete: { viewModel.deleteTask(by: task.id) },
                        onEdit: { showingEditTask = task }
                    )
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // TaskType Colors
    private func typeColor(for type: TaskType) -> Color {
        switch type {
        case .personal: return .blue
        case .work: return .orange
        case .shopping: return .green
        case .fitness: return .red
        case .study: return .purple
        case .finance: return .teal
        }
    }
}

