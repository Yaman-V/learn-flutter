# Budget App

A lightweight, responsive budgeting app. I built this as the final assignment for my Flutter class to demonstrate state management, dynamic UI updates, and clean widget architecture.

Currently, this app runs entirely in-memory (no backend or local database), prioritizing a smooth, working UI and real-time state recalculations.

## Features

- **Dynamic Budget Overview:** A live-updating donut chart showing exactly where your money is going.
- **Category Progress Bars:** Visual indicators for category budgets that change from green to amber to red as you approach your limits.
- **Category & Transaction Management:** Full ability to add, edit, and delete both transactions and custom budget categories.
- **Real-Time Math:** Adding or editing a transaction instantly recalculates the available account balance and category spent totals.
- **Overdraft Alerts:** A warning dialog automatically pops up if a transaction drops your main balance below zero.
- **Dark & Light Mode:** A quick toggle in the app bar to switch themes on the fly.

## Tech Stack & Packages

This project intentionally keeps dependencies to a minimum to focus on core Flutter concepts:

- **Flutter / Dart**
- **provider:** For reactive, app-wide state management using a single ChangeNotifier.
- **fl_chart:** For rendering the responsive donut chart.
- **intl:** For clean date and currency formatting.

## How to Run

1. Clone or download this project folder.
2. Open your terminal in the project directory and grab the dependencies:

```bash
flutter pub get

```

3. Launch the app on your connected device or emulator:

```bash
flutter run

```
