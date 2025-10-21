# 📝 To-Do App --- Flutter Task Manager

A modern and responsive **Task Management App** built with **Flutter**and **GetX** for state management.This app helps users easily organize their daily tasks with reminders, themes, and an intuitive UI.

------------------------------------------------------------------------

## Features

**Add, Edit & Delete Tasks**
Easily create new tasks, update them, or remove completed ones.

**Date-Based Filtering**
Tasks are displayed dynamically based on the selected date using the **Date Picker Timeline**.

**Smart Task Scheduling**
Supports task repetition: 
- Daily tasks
- Weekly tasks
- Monthly tasks

**Auto-Cleanup**
Old or expired tasks are automatically deleted when the app starts.

**Dark & Light Mode**
Seamless theme switching powered by **GetX** and **ThemeServices**.

**Responsive UI**
Optimized for both **portrait** and **landscape** orientations --- 
adjusts layout dynamically without overflow.

**Local Database (Sqflite)**
All task data is stored locally using SQLite for persistence and offline use.

**Reactive UI with GetX**
UI updates automatically whenever the task list changes --- no manual setState calls needed.

------------------------------------------------------------------------

## 🧩 Architecture Overview

    lib/
    │
    ├── controllers/
    │   └── task_controller.dart       # Handles task logic and reactive state with GetX
    │
    ├── models/
    │   └── task.dart                  # Task data model
    │
    ├── services/
    │   └── db_helper.dart             # Manages local SQLite database
    │   └── theme_services.dart        # Handles theme switching (light/dark)
    │
    ├── ui/
    │   ├── pages/
    │   │   ├── home_page.dart         # Main home screen showing tasks
    │   │   └── add_task_page.dart     # UI to create new tasks
    │   │
    │   ├── widgets/
    │   │   ├── button.dart            # Reusable custom button widget
    │   │   ├── task_tile.dart         # Task display widget
    │   │
    │   ├── theme.dart                 # App theme styles
    │   └── size_config.dart           # Responsive sizing helper
    │
    └── main.dart                      # App entry point

------------------------------------------------------------------------

## Technologies Used

-   **Flutter** --- Cross-platform framework for building the UI\
-   **Dart** --- Programming language for Flutter\
-   **GetX** --- For state management, dependency injection, and
    navigation\
-   **Sqflite** --- Local database storage\
-   **Intl** --- Date formatting and localization\
-   **Flutter SVG** --- For scalable vector graphics icons\
-   **Date Picker Timeline** --- For horizontal date selection

------------------------------------------------------------------------

## App Flow

1.  **App Initialization**
    -   Database is initialized (`DBHelper.initDB()`)
    -   Expired tasks are auto-deleted
    -   All tasks are fetched
2.  **Home Page**
    -   Displays today's date
    -   "Add Task" button opens the Add Task Page
    -   Date picker allows filtering tasks by day
3.  **Add Task Page**
    -   Add new task with title, time, and repeat options
    -   Task is saved in SQLite database
4.  **Task List**
    -   Displays tasks dynamically using `Obx` (reactive UI)
    -   Swipe or tap task to mark complete or delete

------------------------------------------------------------------------


## Highlights

-   Clean and maintainable architecture\
-   Minimal rebuilds thanks to GetX reactive observables\
-   Adaptive layout for both orientations\
-   Local storage (works fully offline)\
-   Auto cleanup for old tasks

------------------------------------------------------------------------

##  UI Preview 
![Light](images/Dashboard(light).jpg)  
![Dark](images/Dashboard(Dark).jpg) 
![Add Task](images/AddItem(Dark).jpg)
![Show Task](images/ShowTask(1).jpg)
![Show Task](images/ShowTask(2).jpg)
![Show Task](images/ShowTask(3).jpg)
![Show Task](images/ShowTask(4).jpg)
![Show Task](images/ShowTask(5).jpg)
![Show Task](images/ShowTask(6).jpg)

------------------------------------------------------------------------


## 📚 Future Enhancements

-   Add notifications for upcoming tasks\
-   Cloud sync with Firebase\
-   Task categories and color labels\
-   Search and filter functionality

------------------------------------------------------------------------

## 👨‍💻 Author

**Mazen Ibrahim Abdelmaguid Kandil**\
🎓 Software Engineer  
📧 ibrahimmazen945@gmail.com\
💼 [LinkedIn Profile](https://www.linkedin.com/in/mazenibrahim)
