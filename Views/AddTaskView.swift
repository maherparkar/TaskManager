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
                // ✅ Title
                Section(header: Text("Task Title")) {
                    TextField("Enter task title", text: $title)
                        .textFieldStyle(.roundedBorder)
                }
                
                // ✅ Due Date
                Section(header: Text("Due Date")) {
                    DatePicker("Select date", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
                
                // ✅ Task Type
                Section(header: Text("Category")) {
                    Picker("Task Type", selection: $selectedType) {
                        ForEach(TaskType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.addTask(title: title, dueDate: dueDate, type: selectedType)
                            dismiss()
                        } catch {
                            errorMessage = ErrorMessage(message: error.localizedDescription)
                        }
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
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

