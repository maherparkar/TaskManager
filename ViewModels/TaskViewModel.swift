import Foundation

// Lightweight persistence model
struct StoredTask: Codable, Identifiable {
    var id: UUID
    var title: String
    var dueDate: Date
    var isCompleted: Bool
    var type: TaskType
}

// Task Errors
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

// Task ViewModel
class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet { saveTasks() }
    }
    
    private let tasksKey = "savedTasks"
    
    init() {
        loadTasks()
    }
    
    // Add Task
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
        case .fitness:
            newTask = FitnessTask(title: title, dueDate: dueDate)
        case .study:
            newTask = StudyTask(title: title, dueDate: dueDate)
        case .finance:
            newTask = FinanceTask(title: title, dueDate: dueDate)
        }
        
        tasks.append(newTask)
    }
    
    // toggle Completion
    func toggleCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            tasks[index] = tasks[index]   // ✅ force update
        }
    }

    // Mark All Complete
    func markAllAsComplete() {
        for i in 0..<tasks.count {
            tasks[i].isCompleted = true
        }
    }
    
    // Pending tasks by type
    func pendingTasks(for type: TaskType) -> [Task] {
        tasks.filter { !$0.isCompleted && $0.type == type }
    }

    // Completed tasks by type
    func completedTasks(for type: TaskType) -> [Task] {
        tasks.filter { $0.isCompleted && $0.type == type }
    }

    //  Delete by ID
    func deleteTask(by id: UUID) {
        tasks.removeAll { $0.id == id }
    }

    // clear Completed
    func clearCompleted() {
        tasks.removeAll { $0.isCompleted }
    }
    
    // pdate Task
    func updateTask(task: Task) throws {
        guard !task.title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw TaskError.invalidTitle
        }
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }

    // Persistence
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
            case .fitness:
                task = FitnessTask(title: stored.title, dueDate: stored.dueDate)
            case .study:
                task = StudyTask(title: stored.title, dueDate: stored.dueDate)
            case .finance:
                task = FinanceTask(title: stored.title, dueDate: stored.dueDate)
            }
            task.isCompleted = stored.isCompleted // ✅ Restore state
            return task
        }
    }
}

