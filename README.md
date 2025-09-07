//
//  README.md
//  task_manager
//
//  Created by Maher Parkar on 8/9/2025.
//

# 📱 Task Manager iOS App

An iOS application built with **SwiftUI** that demonstrates **Object-Oriented Programming (OOP)**, **Protocol-Oriented Programming (POP)**, and the **MVVM architecture**.
This project was developed as part of the iOS Application Development assessment.

---

## 🚀 Features

- ✅ Add, edit, delete tasks
- ✅ Categorize tasks into **Personal, Work, Shopping**
- ✅ Mark tasks as complete/incomplete with a tap
- ✅ Separate sections for **Active** and **Completed** tasks
- ✅ Persist tasks using **UserDefaults** (saved between app launches)
- ✅ Clear all completed tasks
- ✅ Mark all tasks as complete in one tap
- ✅ Error handling for invalid input (e.g., empty task title)
- ✅ Unit tests covering task management and persistence

---

## 🏗️ Architecture

The app follows the **MVVM pattern**:

- **Model**
  - `Task` (base class)
  - `PersonalTask`, `WorkTask`, `ShoppingTask` (subclasses via inheritance)
  - `StoredTask` (Codable struct for lightweight persistence)
  - `TaskProtocol` (protocol ensuring consistency across task types)

- **ViewModel**
  - `TaskViewModel` (handles adding, deleting, toggling, saving & loading tasks)

- **View**
  - `TaskListView` (main screen with Active + Completed sections)
  - `AddTaskView` (modal sheet for adding tasks)
  - `TaskRowView` (row with title, due date, and type indicator)

---

## 🧑‍💻 Object-Oriented Concepts

- **Encapsulation** → Task properties (title, dueDate, isCompleted) are wrapped inside the `Task` class.
- **Inheritance** → `PersonalTask`, `WorkTask`, and `ShoppingTask` extend `Task`.
- **Composition** → `TaskViewModel` manages collections of `Task` objects.
- **Polymorphism** → Different task types behave uniformly when managed via the base `Task` class.

---

## 📐 Protocol-Oriented Concepts

- `TaskProtocol` defines the essential properties and methods (`id`, `title`, `dueDate`, `isOverdue`, etc.).
- `Task` and its subclasses conform to this protocol.
- Ensures reusability, consistency, and modular design.

---

## ⚡ Error Handling

- Custom `TaskError` enum handles invalid inputs.
- For example:
  - Adding a task with an empty title throws `.invalidTitle` error.
- Errors are displayed in SwiftUI using `.alert`.

---

## 🧪 Testing & Debugging

Unit tests are included in **`TaskViewModelTests.swift`**.

They cover:
- Adding tasks (valid + invalid input)
- Toggling completion
- Deleting tasks
- Mark All as Complete
- Clearing Completed tasks
- Persistence (saving + loading from UserDefaults)

Run tests in Xcode with:
```bash
⌘U  (Command + U)
