import Foundation

// MARK: - Lightweight persistence model
struct StoredTask: Codable, Identifiable {
    var id: UUID
    var title: String
    var dueDate: Date
    var isCompleted: Bool
    var type: TaskType
}

// MARK: - Task Errors
enum TaskError: Error, LocalizedError, Identifiable {
    case invalidTitle
    
    var id: String { self.localizedDescription }
    
    var errorDescription: String? {
        switch self {
        case .invalidTitle:
            return "Task title cannot be empty."
        }
    }
}

// MARK: - Task ViewModel
class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet { saveTasks() }
    }
    
    private let tasksKey = "savedTasks"
    
    init() {
        loadTasks()
    }
    
    // MARK: - Add Task
    func addTask(title: String, dueDate: Date, type: TaskType) throws {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw TaskError.invalidTitle
        }
        
        let newTask: Task
        switch type {
        case .personal:
            newTask = PersonalTask(title: title, dueDate: dueDate)
        case .work:
            newTask = WorkTask(title: title, dueDate: dueDate)
        case .shopping:
            newTask = ShoppingTask(title: title, dueDate: dueDate)
        }
        
        tasks.append(newTask)
    }
    
    // MARK: - Delete Task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // MARK: - Toggle Completion
    func toggleCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            tasks[index] = tasks[index]   // ✅ forces SwiftUI to see array change
        }
    }

    
    // MARK: - Mark All Complete
    func markAllAsComplete() {
        for i in 0..<tasks.count {
            tasks[i].isCompleted = true
        }
    }
    
    // MARK: - Clear Completed
    func clearCompleted() {
        tasks.removeAll { $0.isCompleted }
    }
    
    // MARK: - Persistence
    private func saveTasks() {
        let storedTasks = tasks.map {
            StoredTask(
                id: $0.id,
                title: $0.title,
                dueDate: $0.dueDate,
                isCompleted: $0.isCompleted,
                type: $0.type
            )
        }
        
        if let encoded = try? JSONEncoder().encode(storedTasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadTasks() {
        guard let savedData = UserDefaults.standard.data(forKey: tasksKey),
              let decoded = try? JSONDecoder().decode([StoredTask].self, from: savedData) else {
            return
        }
        
        tasks = decoded.map { stored in
            let task: Task
            switch stored.type {
            case .personal:
                task = PersonalTask(title: stored.title, dueDate: stored.dueDate)
            case .work:
                task = WorkTask(title: stored.title, dueDate: stored.dueDate)
            case .shopping:
                task = ShoppingTask(title: stored.title, dueDate: stored.dueDate)
            }
            task.isCompleted = stored.isCompleted // ✅ Restore state
            return task
        }
    }
}

