# Super Store

> **Status: ⏸ Paused** — this is a personal **learning project**, not a production app.

A small e-commerce app built in Flutter, consuming the live [DummyJSON Products API](https://dummyjson.com/products). Built as a structured learning project focused on Flutter app architecture and state management.

## Learning Goals

- Practice a clean, layered Flutter architecture (models → services → state → UI)
- Get comfortable with async data fetching and loading/error/success UI states
- Learn `Provider` for shared, cross-widget state (cart)
- Build habits around validating assumptions against real, messy API data rather than trusting a model on sample data alone

## Features

- Product grid fetched live from the DummyJSON API, with loading, error, and success states
- Product detail screen (hero image, rating, brand, description, quantity selector)
- Cart state via `CartProvider` — add/remove items, per-product quantity tracking
- Live cart count badge on the home screen, driven entirely by `ChangeNotifier`/`Consumer` (no manual `setState` for shared state)

## Architecture

The app is organized into four layers, each with a single responsibility:

| Layer                | Location                       | Responsibility                                                                                                                  |
| -------------------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| **Models**           | `lib/models/`                  | Plain Dart classes mirroring API data. No UI or state dependency.                                                               |
| **Services**         | `lib/services/`                | Talks to the network only — HTTP call, status check, decode, unwrap response envelope, map to models. No business logic.        |
| **State management** | `lib/providers/`               | `ChangeNotifier` classes (e.g. `CartProvider`). Business logic — cart totals, quantity rules — lives here, not in models or UI. |
| **UI**               | `lib/screens/`, `lib/widgets/` | Renders only. No calculations or business decisions.                                                                            |

This separation was deliberately kept simple for a learning project — layered enough to have a clear reason for every architectural choice, without over-engineering for an app this size.

## Tech Stack

- **Flutter / Dart**
- [`http`](https://pub.dev/packages/http) — networking
- [`provider`](https://pub.dev/packages/provider) — state management

## Project Structure

```
lib/
├── models/
│   ├── product.dart
│   └── cart_item.dart
├── services/
│   └── product_service.dart
├── providers/
│   └── cart_provider.dart
├── screens/
│   ├── product_list_screen.dart
│   └── product_detail_screen.dart
└── widgets/
```

## API

Data comes from [`dummyjson.com/products`](https://dummyjson.com/products). Notably:

- Responses are wrapped in an envelope (`{ products: [...], total, skip, limit }`), not a bare array — handled in `ProductService`.
- The `brand` field is genuinely _absent_ (not just null) for some grocery-category products in the live dataset. This was caught via a full-dataset field survey (checking every product for both missing keys and present-but-null values, not just a sample) and modeled honestly as `String? brand`, with the "no brand" display decision left to the UI layer.

## Getting Started

```bash
flutter pub get
flutter run
```

Requires a working Flutter SDK install and an internet connection (the app fetches live data — no local/mock data or offline support).

## Known Limitations

- **Pagination not implemented** — DummyJSON defaults to a page size of 30; only the first page is currently fetched.
- **Coarse error handling** — the service layer doesn't yet distinguish a bad status code from a network failure outright.
- **No dedicated cart screen yet** — items can be added to the cart and the count is reflected live in a badge, but there's no screen yet to view, adjust, or remove cart contents directly.
- **No checkout flow, search/filtering, or persistence** — cart state currently resets on app restart.

## Roadmap / To-Do

Closing the core shopping flow:

- [ ] Cart screen — list cart items, adjust/remove quantity per line, running total
- [ ] Checkout/totals flow (mock — no real payment)

Loose ends to close:

- [ ] Real pagination beyond page 1 (infinite scroll or "load more")
- [ ] Proper error-type handling (bad status vs. no network) in the service layer

Not yet started:

- [ ] Search / filtering
- [ ] Local persistence, so the cart survives an app restart
- [ ] Basic unit tests for the model and service layers
- [ ] Navigation shell (bottom nav — Home / Cart, etc.) once there's more than one top-level destination

This list is not a fixed order — free to branch as priorities change when the project resumes.

## Status

Currently **paused** while focusing on other coursework/projects — resuming is planned once bandwidth allows. Architecture and the core browse → detail → add-to-cart flow are in place and hardened against real API data; the cart screen and everything in the roadmap above are the next planned steps whenever work picks back up.
