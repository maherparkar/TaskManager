import Foundation

class PersonalTask: Task {
    var notes: String?
    
    init(title: String, dueDate: Date, notes: String? = nil) {
        self.notes = notes
        super.init(title: title, dueDate: dueDate, type: .personal)
    }
}
