import SwiftUI

struct TaskRowView: View {
    @ObservedObject var task: Task   // ✅ now observes changes
    var toggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    toggle()
                }
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .imageScale(.large)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
                    .strikethrough(task.isCompleted, color: .gray)
                
                Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(task.isCompleted ? .gray : .secondary)
                
                if task is PersonalTask {
                    Text("Personal Task").font(.caption).foregroundColor(.blue)
                } else if task is WorkTask {
                    Text("Work Task").font(.caption).foregroundColor(.red)
                } else if task is ShoppingTask {
                    Text("Shopping Task").font(.caption).foregroundColor(.orange)
                }
            }
            Spacer()
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle()) // ✅ row is fully tappable
        .onTapGesture {
            withAnimation {
                toggle()
            }
        }
    }
}
