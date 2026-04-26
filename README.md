# Pedivo

Activity verification dashboard for step tracking sessions.

## Tech Stack and Why

- `Flutter` + `Dart`: fast cross-platform delivery with a single codebase.
- `flutter_bloc`: explicit state transitions and testable presentation logic.
- `go_router`: predictable route config for feed/detail navigation.
- Clean architecture style layering (`presentation` -> `domain` -> `data`) to keep core logic independent from UI and data source details.

## How to Run the Project

### Prerequisites

- Flutter SDK (matching `pubspec.yaml` constraints)
- Android Studio / Xcode tooling installed

### Run in Debug

```bash
flutter pub get
flutter run
```

### Run Tests

```bash
flutter test
```

### Build APK

```bash
flutter build apk --release
```

Output APK path:

`build/app/outputs/flutter-apk/app-release.apk`

## Trade-offs Made (Time Constraint)

- Kept verification rules simple and deterministic (distance/duration/speed thresholds).
- Map route line is intentionally simplified to a single smooth curved path for clarity.
- Focused on core flow and maintainable structure over advanced visual polish.
- Used Custompainter for the route lines and a map placeholder and not an actual map.

## What I Would Improve With More Time

- Add repository tests and widget tests for major UI states.
- Add offline caching and refresh strategy for session data.
- Add richer map behavior (fit bounds animation, route stats overlays, map style toggle).

