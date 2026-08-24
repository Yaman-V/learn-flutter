# Learn Flutter

My Flutter learning journal — part university coursework, part self-guided practice. This repo tracks the path from Dart fundamentals through Flutter widgets, state management, and small full apps.

> 🚧 **Status: in progress.** New classes, assignments, and mini-projects are added as I go through the course.

## Structure

```
Learning-Flutter/
├── dart-fundamentals/       # Pure Dart basics, before touching Flutter widgets
└── learning_flutter_app/    # Single Flutter app hosting everything below
    └── lib/
        ├── topics/classes/         # In-class exercises
        ├── topics/assignments/     # Take-home assignments
        └── topics/mini_projects/   # Larger, self-contained practice apps
```

`learning_flutter_app` is a single hub app — each class, assignment, and mini-project is a self-contained screen registered in one place, so everything is browsable from one home screen instead of being scattered across separate projects.

## What's covered so far

**Dart fundamentals**
Hello world → collections → functions → OOP & asynchronous programming.

**Classes**

| # | Topic |
|---|-------|
| 01 | Hello Flutter |
| 02 | Scaffold elements |
| 03 | List View |
| 04 | Animations and Forms |
| 05 | Data from API |
| 06 | API: University App |

**Assignments**

| # | Topic |
|---|-------|
| 05 | Drawer |
| 06 | Personal Profile |
| 07 | List View |
| 08 | Forms: User Inputs |

**Mini-projects**

| Project | Description |
|---|---|
| Rehab Tourism | Browsing app for tourist sites, with categories and a splash screen |
| To-Do App | Task manager, used as a state-management practice ground |
| Book API Explorer | Fetches and displays book data from an external API |
| Weather App | Fetches and displays weather data from an external API |

## Tech stack

- Flutter / Dart
- `provider` — state management
- `http` — API calls
- `easy_localization` — localization
- `google_fonts`, `url_launcher`, `cupertino_icons`

## Running it

```bash
cd Learning-Flutter/learning_flutter_app
flutter pub get
flutter run
```

## What's next

Currently working through state management in more depth (refactoring the To-Do app with Provider, with Riverpod as the longer-term goal for real projects).
