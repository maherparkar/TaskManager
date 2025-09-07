import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    
    @State private var title = ""
    @State private var dueDate = Date()
    @State private var selectedType: TaskType = .personal
    @State private var errorMessage: ErrorMessage?
    
    var body: some View {
        NavigationView {
            Form {
                // ✅ Task Title
                TextField("Task Title", text: $title)
                
                // ✅ Due Date Picker
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                
                // ✅ Task Type Picker
                Picker("Task Type", selection: $selectedType) {
                    ForEach(TaskType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.addTask(title: title, dueDate: dueDate, type: selectedType)
                            dismiss()
                        } catch {
                            errorMessage = ErrorMessage(message: error.localizedDescription)
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
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

