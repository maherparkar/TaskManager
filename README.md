# 📱 Task Manager iOS App

An iOS application built with **SwiftUI** that demonstrates **Object-Oriented Programming (OOP)**, **Protocol-Oriented Programming (POP)**, and the **MVVM architecture**.
This project was developed as part of the iOS Application Development assessment.

---

## 🚀 Features

- ✅ Add, edit, delete tasks
- ✅ Categorize tasks into **Personal, Work, Shopping, Fitness, Study, Finance**
- ✅ Color-coded + icon-based rows for task categories
- ✅ Mark tasks as complete/incomplete with a tap
- ✅ Separate sections for **Active** and **Completed** tasks
- ✅ Filter tasks by category with a **scrollable filter bar**
- ✅ Persist tasks using **UserDefaults** (saved between app launches)
- ✅ Clear all completed tasks in one tap
- ✅ Mark all tasks as complete in one tap
- ✅ Error handling for invalid input (e.g., empty task title)
- ✅ Unit tests covering task management and persistence
- ✅ Modern UI with rounded cards, shadows, and grouped styling

---

## 🖼️ Screenshots
                                        
Screenshots of the app are available in the **`/screenshots`** folder of this repository.
---

## 🏗️ Architecture

The app follows the **MVVM pattern**:

- **Model**
  - `Task` (base class)
  - `PersonalTask`, `WorkTask`, `ShoppingTask`, `FitnessTask`, `StudyTask`, `FinanceTask` (subclasses via inheritance)
  - `StoredTask` (Codable struct for lightweight persistence)
  - `TaskProtocol` (protocol ensuring consistency across task types)

- **ViewModel**
  - `TaskViewModel` (handles adding, editing, deleting, toggling, saving & loading tasks)

- **View**
  - `TaskListView` (main screen with Active + Completed sections, filter bar)
  - `AddTaskView` (modal sheet for adding tasks)
  - `EditTaskView` (modal sheet for editing tasks)
  - `TaskRowView` (custom row with title, due date, icons, and color-coded type labels)

---

## 🧑‍💻 Object-Oriented Concepts

- **Encapsulation** → Task properties (`title`, `dueDate`, `isCompleted`) are wrapped inside the `Task` class.
- **Inheritance** → `PersonalTask`, `WorkTask`, `ShoppingTask`, `FitnessTask`, `StudyTask`, and `FinanceTask` extend `Task`.
- **Composition** → `TaskViewModel` manages collections of `Task` objects.
- **Polymorphism** → Different task types behave uniformly when managed via the base `Task` class.

---

## 📐 Protocol-Oriented Concepts

- `TaskProtocol` defines the essential properties and methods (`id`, `title`, `dueDate`, `isOverdue`, etc.).
- `Task` and its subclasses conform to this protocol.
- Ensures reusability, consistency, and modular design.

---

## 🎨 UI/UX Enhancements

- Horizontal **category filter bar** with dynamic highlighting
- **Icons + colors** for task types:
  - 🟦 Personal → Blue / 👤 `person.fill`
  - 🟧 Work → Orange / 💼 `briefcase.fill`
  - 🟩 Shopping → Green / 🛒 `cart.fill`
  - 🟥 Fitness → Red / ❤️ `heart.fill`
  - 🟪 Study → Purple / 📚 `book.fill`
  - 🟦 Finance → Teal / 💲 `dollarsign.circle.fill`
- Task rows styled as **rounded cards with shadows**
- Inline **edit** ✏️ and **delete** 🗑️ buttons for each task

---

## ⚡ Error Handling

- Custom `TaskError` enum handles invalid inputs.
- Example: Adding a task with an empty title throws `.invalidTitle` error.
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
                                        
                                        
## Github Link
https://github.com/maherparkar/TaskManager

                                        
