# Employee Management

A Flutter application for managing employee information.

## System Requirements

- Flutter Version: 3.27.1 (stable)
- Dart Version: 3.6.0
- DevTools Version: 2.40.2
- Android SDK: 34.0.0
- Java Version: OpenJDK 17.0.14

## Getting Started

### Prerequisites

1. Install Flutter by following the official [Flutter installation guide](https://docs.flutter.dev/get-started/install)
2. Ensure your development environment matches the above system requirements
3. Install the required IDE (Android Studio or VS Code) with Flutter and Dart plugins

### Setup Instructions

1. Clone the repository:

   ```bash
   git clone [repository-url]
   cd employee_management
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the Hive generator for model classes:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run the application:
   ```bash
   flutter run
   ```

### Supported Platforms

- Android (Mobile)
- Web (Currently Chrome setup required)

Note: Web development requires Chrome to be installed. If you get the error "Cannot find Chrome executable", you'll need to set up Chrome or specify the Chrome executable path.

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter API Reference](https://api.flutter.dev/)

## Troubleshooting

If you encounter any version mismatch issues, ensure your Flutter environment matches the following (from `flutter doctor`):

```
Flutter (Channel stable, 3.27.1)
Dart version 3.6.0
DevTools version 2.40.2
```

To check your environment, run:

```bash
flutter doctor -v
```

If you need to switch Flutter versions, use:

```bash
flutter version 3.27.1
```

### Common Issues

1. **Chrome not found error**:

   - Install Google Chrome, or
   - Set the CHROME_EXECUTABLE environment variable to your Chrome installation path

2. **Hive generation errors**:
   If you encounter any issues with Hive models, try cleaning and rebuilding:
   ```bash
   flutter clean
   flutter pub get
   flutter pub run build_runner clean
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
