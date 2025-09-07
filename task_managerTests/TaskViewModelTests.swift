import XCTest
@testable import task_manager

final class TaskViewModelTests: XCTestCase {
    
    var viewModel: TaskViewModel!
    
    override func setUp() {
        super.setUp()
        // Reset persistence before every test
        UserDefaults.standard.removeObject(forKey: "savedTasks")
        viewModel = TaskViewModel()
        viewModel.tasks.removeAll() // ✅ start fresh in memory
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Add Task
    func testAddTask() throws {
        try viewModel.addTask(title: "Buy Milk", dueDate: Date(), type: .shopping)
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "Buy Milk")
        XCTAssertEqual(viewModel.tasks.first?.type, .shopping)
    }
    
    func testAddTaskWithEmptyTitleThrowsError() {
        XCTAssertThrowsError(try viewModel.addTask(title: "   ", dueDate: Date(), type: .personal)) { error in
            XCTAssertEqual(error as? TaskError, TaskError.invalidTitle)
        }
    }
    
    // MARK: - Toggle Completion
    func testToggleCompletion() throws {
        try viewModel.addTask(title: "Finish Report", dueDate: Date(), type: .work)
        let task = viewModel.tasks.first!
        
        viewModel.toggleCompletion(task: task)
        XCTAssertTrue(viewModel.tasks.first!.isCompleted)
        
        viewModel.toggleCompletion(task: task)
        XCTAssertFalse(viewModel.tasks.first!.isCompleted)
    }
    
    // MARK: - Delete Task
    func testDeleteTask() throws {
        try viewModel.addTask(title: "Call Mom", dueDate: Date(), type: .personal)
        XCTAssertEqual(viewModel.tasks.count, 1)
        
        viewModel.deleteTask(at: IndexSet(integer: 0))
        XCTAssertTrue(viewModel.tasks.isEmpty)
    }
    
    // MARK: - Mark All As Complete
    func testMarkAllAsComplete() throws {
        try viewModel.addTask(title: "Task 1", dueDate: Date(), type: .work)
        try viewModel.addTask(title: "Task 2", dueDate: Date(), type: .shopping)
        
        viewModel.markAllAsComplete()
        XCTAssertTrue(viewModel.tasks.allSatisfy { $0.isCompleted })
    }
    
    // MARK: - Clear Completed
    func testClearCompleted() throws {
        try viewModel.addTask(title: "Task 1", dueDate: Date(), type: .personal)
        try viewModel.addTask(title: "Task 2", dueDate: Date(), type: .work)
        
        viewModel.tasks[0].isCompleted = true
        viewModel.clearCompleted()
        
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "Task 2")
    }
    
    // MARK: - Persistence
    func testPersistenceSaveAndLoad() throws {
        try viewModel.addTask(title: "Persistent Task", dueDate: Date(), type: .shopping)
        
        // simulate reload
        let newViewModel = TaskViewModel()
        XCTAssertTrue(newViewModel.tasks.contains { $0.title == "Persistent Task" })
    }
}

