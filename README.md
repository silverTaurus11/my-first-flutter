# 🚀 My First Flutter

A cross-platform mobile application (Android & iOS only) built with **Flutter**. This project integrates modern tools such as Firebase, local database, reactive programming, and animations to create a solid mobile foundation.

---

## 📱 Platforms Supported

- ✅ Android
- ✅ iOS

---

## 🔥 Features

- 📊 **Firebase Analytics** – Track user events and engagement
- 🐞 **Firebase Crashlytics** – Real-time crash reporting
- 📩 **Firebase Messaging** – Push notifications
- 🔔 **Local Notification** – In-app notification support
- 🗃 **Floor Database** – Lightweight SQLite abstraction for persistence
- 🌐 **Retrofit (via Retrofit.dart)** – RESTful networking
- 🔁 **RxDart** – Reactive streams & observables
- 🎉 **Lottie** – Beautiful animations
- 📦 **Shared Preferences** – Store small local data (e.g., tokens)
- 📄 **JSON Parsing** – Parse API responses into Dart models

---

## 🧱 Architecture Overview

- Clean Architecture principles
- Separation of concerns:
  - Data Layer (API, DB)
  - Domain Layer (Model, Repository)
  - Presentation Layer (UI, Logic)

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest
  firebase_analytics: ^latest
  firebase_crashlytics: ^latest
  firebase_messaging: ^latest
  flutter_local_notifications: ^latest
  floor: ^latest
  retrofit: ^latest
  dio: ^latest
  rxdart: ^latest
  lottie: ^latest
  shared_preferences: ^latest
  json_annotation: ^latest
