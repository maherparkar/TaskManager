//
//  TaskRowView.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//


import SwiftUI

struct TaskRowView: View {
    var task: Task
    var toggle: () -> Void
    
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .contentShape(Rectangle()) // makes whole row tappable
        .onTapGesture { toggle() }
    }
}
