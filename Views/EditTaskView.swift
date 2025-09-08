import SwiftUI

struct EditTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel
    
    @State var task: Task
    @State private var error: TaskError? = nil
    
    var body: some View {
        NavigationView {
            Form {
                // ✅ Title
                Section(header: Text("Task Title")) {
                    TextField("Enter task title", text: $task.title)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("EditTaskTitleField")
                }
                
                // ✅ Due Date
                Section(header: Text("Due Date")) {
                    DatePicker("Select date", selection: $task.dueDate, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }
                
                // ✅ Task Type
                Section(header: Text("Category")) {
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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.updateTask(task: task)
                            dismiss()
                        } catch let taskError as TaskError {
                            self.error = taskError
                        } catch {
                            self.error = .invalidTitle
                        }
                    }
                    .disabled(task.title.trimmingCharacters(in: .whitespaces).isEmpty)
                    .accessibilityIdentifier("EditSaveButton")
                }
            }
        }
        .alert(item: $error) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

