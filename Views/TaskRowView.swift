import SwiftUI

struct TaskRowView: View {
    var task: Task
    var toggle: () -> Void
    var onDelete: () -> Void
    var onEdit: () -> Void
    
    // Task type color
    private var typeColor: Color {
        switch task.type {
        case .personal: return .blue
        case .work: return .orange
        case .shopping: return .green
        case .fitness: return .red
        case .study: return .purple
        case .finance: return .teal
        }
    }
    
    // Task type icon
    private var typeIcon: String {
        switch task.type {
        case .personal: return "person.fill"
        case .work: return "briefcase.fill"
        case .shopping: return "cart.fill"
        case .fitness: return "heart.fill"
        case .study: return "book.fill"
        case .finance: return "dollarsign.circle.fill"
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // Completion toggle
            Button(action: toggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : typeColor)
                    .font(.system(size: 22, weight: .bold))
            }
            
            VStack(alignment: .leading, spacing: 6) {
                // Title + Icon
                HStack {
                    Image(systemName: typeIcon)
                        .foregroundColor(typeColor)
                        .font(.system(size: 16))
                    
                    Text(task.title)
                        .font(.headline)
                        .lineLimit(1)
                        .strikethrough(task.isCompleted, color: .gray)
                        .foregroundColor(task.isCompleted ? .gray : .primary)
                }
                
                // Due date
                Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Badge for type
                Text(task.type.rawValue)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 8)
                    .background(typeColor.gradient)
                    .cornerRadius(6)
            }
            Spacer()
            
            // Edit + Delete Actions
            HStack(spacing: 16) {
                Button(action: onEdit) {
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                .buttonStyle(BorderlessButtonStyle())
                
                Button(action: onDelete) {
                    Image(systemName: "trash.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        )
        .padding(.vertical, 6)
    }
}

