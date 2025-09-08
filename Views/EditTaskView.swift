import SwiftUI

/// A view that allows editing an existing task.
/// Users can update the task's title, due date, and category.
struct EditTaskView: View {
    /// Dismisses the current view (used for closing the sheet).
    @Environment(\.dismiss) var dismiss
    
    /// The shared TaskViewModel that manages all tasks.
    @ObservedObject var viewModel: TaskViewModel
    
    /// The task currently being edited.
    @State var task: Task
    
    /// Stores any validation errors while saving.
    @State private var error: TaskError? = nil
    
    var body: some View {
        NavigationView {
            Form {
                // Task Title Section
                Section(header: Text("Task Title")) {
                    /// Text field to edit the task title.
                    TextField("Enter task title", text: $task.title)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("EditTaskTitleField")
                }
                
                // Due Date Section
                Section(header: Text("Due Date")) {
                    /// Date picker to update the task's due date.
                    DatePicker("Select date", selection: $task.dueDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
                
                // Task Type Section
                Section(header: Text("Category")) {
                    /// Picker to update the category of the task.
                    Picker("Task Type", selection: $task.type) {
                        ForEach(TaskType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .accessibilityIdentifier("EditTaskTypePicker")
                }
            }
            .navigationTitle("Edit Task")
            .toolbar {
                // Cancel Button → dismisses without saving
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                // Save Button → updates the task in the ViewModel
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.updateTask(task: task)
                            dismiss()
                        } catch let taskError as TaskError {
                            self.error = taskError   // Validation error (e.g., empty title)
                        } catch {
                            self.error = .invalidTitle
                        }
                    }
                    // Disable if title is empty
                    .disabled(task.title.trimmingCharacters(in: .whitespaces).isEmpty)
                    .accessibilityIdentifier("EditSaveButton")
                }
            }
        }
        // Error Alert
        .alert(item: $error) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
