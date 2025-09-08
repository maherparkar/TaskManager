import SwiftUI

/// View for adding a new task
struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss      // Environment variable to dismiss the sheet
    @ObservedObject var viewModel: TaskViewModel   // Reference to the task view model
    
    @State private var title = ""            // Stores the task title input
    @State private var dueDate = Date()      // Stores the due date input
    @State private var selectedType: TaskType = .personal  // Selected category
    @State private var errorMessage: ErrorMessage?         // For showing validation errors
    
    var body: some View {
        NavigationView {
            Form {
                // Section for entering the task title
                Section(header: Text("Task Title")) {
                    TextField("Enter task title", text: $title)
                        .textFieldStyle(.roundedBorder)
                }
                
                // Section for selecting due date
                Section(header: Text("Due Date")) {
                    DatePicker("Select date", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
                
                // Section for selecting the task category (type)
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
                // Cancel button → dismisses the sheet without saving
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                // Save button → validates and adds the task
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.addTask(title: title, dueDate: dueDate, type: selectedType)
                            dismiss()
                        } catch {
                            // Show error if task title is invalid
                            errorMessage = ErrorMessage(message: error.localizedDescription)
                        }
                    }
                    // Disable save if title is empty
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
        // Error alert for invalid inputs
        .alert(item: $errorMessage) { msg in
            Alert(
                title: Text("Error"),
                message: Text(msg.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
