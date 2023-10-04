import 'dart:io';

class Task {
  String title;
  String description;
  bool isCompleted;

  Task(this.title, this.description, this.isCompleted);
}

class TaskManager {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
  }

  void editTask(
      int index, String newTitle, String newDescription, bool isCompleted) {
    if (index >= 0 && index < tasks.length) {
      tasks[index].title = newTitle;
      tasks[index].description = newDescription;
      tasks[index].isCompleted = isCompleted;
    } else {
      print("Invalid task index.");
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
    } else {
      print("Invalid task index.");
    }
  }

  void listTasks() {
    if (tasks.isEmpty) {
      print("No tasks found.");
    } else {
      for (int i = 1; i < tasks.length; i++) {
        print("Task #$i:");
        print("Title: ${tasks[i].title}");
        print("Description: ${tasks[i].description}");
        print("Status: ${tasks[i].isCompleted ? 'Completed' : 'Incomplete'}");
        print("");
      }
    }
  }
}

void main() {
  TaskManager taskManager = TaskManager();

  while (true) {
    print("Console Task Manager");
    print("1. Add Task");
    print("2. Edit Task");
    print("3. Delete Task");
    print("4. List Tasks");
    print("5. Exit");
    stdout.write("Enter your choice: ");
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        print("Enter task title: ");
        String title = stdin.readLineSync() ?? '';
        print("Enter task description: ");
        String description = stdin.readLineSync() ?? '';
        Task newTask = Task(title, description, false);
        taskManager.addTask(newTask);
        print("Task added successfully.");
        break;
      case '2':
        print("Enter the index of the task you want to edit: ");
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null) {
          Task existingTask = taskManager.tasks[index];

          print(
              "Enter new task title (or press Enter to keep the current title: ${existingTask.title}): ");
          String? newTitleInput = stdin.readLineSync();
          String newTitle =
              newTitleInput!.isNotEmpty ? newTitleInput : existingTask.title;

          print(
              "Enter new task description (or press Enter to keep the current description: ${existingTask.description}): ");
          String? newDescriptionInput = stdin.readLineSync();
          String newDescription = newDescriptionInput!.isNotEmpty
              ? newDescriptionInput
              : existingTask.description;

          print(
              "Enter new task status (true or false) (or press Enter to keep the current status: ${existingTask.isCompleted}): ");
          String? isCompletedInput = stdin.readLineSync();
          bool isCompleted;

          if (isCompletedInput != null && isCompletedInput.isNotEmpty) {
            try {
              isCompleted = bool.parse(isCompletedInput);
            } catch (e) {
              print(e.toString());
              isCompleted = false;
            }
          } else if (existingTask != null) {
            isCompleted = existingTask.isCompleted;
          } else {
            isCompleted = false;
          }

          taskManager.editTask(index, newTitle, newDescription, isCompleted);
          print("Task edited successfully.");
        } else {
          print("Invalid index.");
        }
        break;

      case '3':
        print("Enter the index of the task you want to delete: ");
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null) {
          taskManager.deleteTask(index);
          print("Task deleted successfully.");
        } else {
          print("Invalid index.");
        }
        break;
      case '4':
        taskManager.listTasks();
        break;
      case '5':
        exit(0);
      default:
        print("Invalid choice. Please try again.");
    }
  }
}
