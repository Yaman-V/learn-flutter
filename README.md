# Learn Flutter

My Flutter learning journey, from Dart fundamentals and Flutter basics to API integration, state management, and full-stack application development.

This repository contains coursework, exercises, assignments, mini-projects, and a full-stack Flutter application built while learning and practicing modern app development.

> 🚧 **Status:** In progress. New lessons, exercises, and projects are added as I continue learning.

## Repository Structure

```text
learn-flutter/
└── Learning-Flutter/
    ├── dart-fundamentals/
    │   └── Pure Dart exercises and language fundamentals
    │
    ├── learning_flutter_app/
    │   ├── topics/
    │   │   ├── classes/
    │   │   ├── assignments/
    │   │   └── mini_projects/
    │   └── Flutter learning hub containing coursework and practice projects
    │
    └── full_stack_app/
        ├── backend/
        │   ├── server.js
        │   ├── package.json
        │   └── package-lock.json
        │
        └── frontend/
            └── book_crud_app/
                ├── lib/
                ├── test/
                └── pubspec.yaml
```

## What I'm Learning

The repository currently covers:

* Dart fundamentals
* Flutter widgets and layouts
* Forms and user input
* Lists and navigation
* Animations
* Working with REST APIs
* State management
* Localization
* Full-stack Flutter application development
* Connecting a Flutter frontend to a Node.js backend
* CRUD operations

## Flutter Learning Hub

`learning_flutter_app` is the main learning application. It brings classes, assignments, and mini-projects together into a single Flutter project so they can be explored from one place.

### Classes

| #  | Topic                |
| -- | -------------------- |
| 01 | Hello Flutter        |
| 02 | Scaffold elements    |
| 03 | List View            |
| 04 | Animations and Forms |
| 05 | Data from API        |
| 06 | API: University App  |

### Assignments

| #  | Topic              |
| -- | ------------------ |
| 05 | Drawer             |
| 06 | Personal Profile   |
| 07 | List View          |
| 08 | Forms: User Inputs |

### Mini-projects

| Project           | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| Rehab Tourism     | Browsing app for tourist sites, categories, and splash screen |
| To-Do App         | Task manager used for practicing state management             |
| Book API Explorer | Fetches and displays book data from an external API           |
| Weather App       | Fetches and displays weather data from an external API        |

## Full-Stack App

The `full_stack_app` is a separate practice project focused on connecting a Flutter frontend to a backend API.

### Architecture

```text
Flutter App
    │
    │ HTTP / JSON
    ▼
Node.js + Express API
    │
    ▼
In-memory Book Data
```

### Frontend

The frontend is a Flutter application named `book_crud_app`.

It currently supports:

* Fetching all books
* Fetching books from the REST API
* Adding a book
* Editing a book
* Deleting a book
* Pull-to-refresh

### Backend

The backend is a Node.js application built with Express.

It provides the following endpoints:

| Method | Endpoint     | Purpose                       |
| ------ | ------------ | ----------------------------- |
| GET    | `/`          | Check that the API is running |
| GET    | `/books`     | Get all books                 |
| GET    | `/books/:id` | Get a single book             |
| POST   | `/books`     | Create a book                 |
| PUT    | `/books/:id` | Update a book                 |
| DELETE | `/books/:id` | Delete a book                 |

The API currently stores books in memory, so data is reset whenever the server restarts.

## Tech Stack

### Flutter

* Flutter
* Dart
* `http`
* Material 3

### Backend

* Node.js
* Express
* CORS

## Running the Projects

### Flutter Learning Hub

```bash
cd Learning-Flutter/learning_flutter_app
flutter pub get
flutter run
```

### Full-Stack App

Start the backend first:

```bash
cd Learning-Flutter/full_stack_app/backend
npm install
npm start
```

The API runs on:

```text
http://localhost:5000
```

Then run the Flutter frontend:

```bash
cd Learning-Flutter/full_stack_app/frontend/book_crud_app
flutter pub get
flutter run
```

### Android Emulator

The current Flutter frontend uses:

```text
http://10.0.2.2:5000/books
```

`10.0.2.2` allows the Android emulator to access the backend running on the host machine.

When using a physical device, replace this with the local IP address of the machine running the backend.

## Current Projects

| Project              | Focus                                                      |
| -------------------- | ---------------------------------------------------------- |
| Learning Flutter App | Flutter lessons, exercises, assignments, and mini-projects |
| To-Do App            | State management                                           |
| Book API Explorer    | REST API integration                                       |
| Weather App          | External API integration                                   |
| Rehab Tourism        | UI, navigation, and app structure                          |
| Full-Stack Book CRUD | Flutter + Node.js + Express + REST API                     |

## What's Next

The next stage of the learning journey is to go deeper into application architecture and state management while continuing to improve the full-stack application.

Planned improvements include:

* More structured Flutter architecture
* Improved state management
* Persistent backend storage
* Better error handling
* API validation
* Authentication and authorization
* More comprehensive testing
* Cleaner separation between UI, services, models, and repositories

## Why This Repository Exists

This repository is primarily a learning journal.

The goal is to document the progression from learning individual Flutter concepts to building applications that communicate with a backend.

Each project represents a step toward becoming more comfortable with Flutter, Dart, APIs, backend development, and full-stack application architecture.
