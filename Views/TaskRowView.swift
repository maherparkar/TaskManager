import SwiftUI

struct TaskRowView: View {
    var task: Task
    var toggle: () -> Void
    
    var body: some View {
        HStack {
            // ✅ Toggle button
            Button(action: toggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .imageScale(.large)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                // ✅ Task title
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
                    .strikethrough(task.isCompleted, color: .gray)
                
                // ✅ Due date
                Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(task.isCompleted ? .gray : .secondary)
                
                // ✅ Task type label
                if let _ = task as? PersonalTask {
                    Text("Personal Task").font(.caption).foregroundColor(.blue)
                } else if let _ = task as? WorkTask {
                    Text("Work Task").font(.caption).foregroundColor(.red)
                } else if let _ = task as? ShoppingTask {
                    Text("Shopping Task").font(.caption).foregroundColor(.orange)
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
        .background(task.isCompleted ? Color(.systemGray6) : Color.clear) // ✅ Dim background
        .cornerRadius(8)
    }
}

