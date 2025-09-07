import XCTest
@testable import task_manager

final class TaskManagerTests: XCTestCase {
    
    func testAddValidTask() throws {
        let viewModel = TaskViewModel()
        XCTAssertNoThrow(try viewModel.addTask(title: "Buy groceries", dueDate: Date()))
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "Buy groceries")
    }
    
    func testAddInvalidTaskThrowsError() {
        let viewModel = TaskViewModel()
        XCTAssertThrowsError(try viewModel.addTask(title: "   ", dueDate: Date())) { error in
            XCTAssertEqual(error as? TaskError, TaskError.invalidTitle)
        }
    }
    
    func testMarkTaskCompleted() throws {
        let viewModel = TaskViewModel()
        try viewModel.addTask(title: "Finish homework", dueDate: Date())
        let task = viewModel.tasks.first!
        
        viewModel.toggleCompletion(task: task)
        
        XCTAssertTrue(viewModel.tasks.first!.isCompleted)
    }
}
