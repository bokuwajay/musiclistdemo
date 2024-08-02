# Documentation

## Introduction

Welcome! This documentation will guide you through setting up and using the app. The app is designed to provide an engaging user experience with an initial animation followed by a music search functionality powered by the iTunes API.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Project Structure](#project-structure)

## Getting Started

To get started with the app, clone the repository and install the necessary dependencies.

```bash
flutter upgrade

git clone https://github.com/bokuwajay/keysoctest.git

cd keysoctest

flutter pub get
```

## Project Structure

```plaintext
lib/
├── config/
│ └── routes/
│   ├── app_route_config.dart
│   └── app_route.dart
├── core/
│ └── api/
│ │ ├── api_helper.dart
│ │ ├── app_interceptor.dart
│ │ └── api_url.dart
│ ├── error/
│ │ ├── exception_conventer.dart
│ │ ├── exceptions.dart
│ │ ├── failure_conventer.dart
│ │ ├── failure_message_to_user.dart
│ │ └── failures.dart
│ └── usecase/
│   └── usecase.dart
├── features/
│ └── iTunes/
│   ├── data/
│   │ ├── datasources/
│   │ │ └── itunes_remote_datasource.dart
│   │ ├── models/
│   │ │ └── track_model.dart
│   │ └── repository/
│   │   └── itunes_repository_impl.dart
│   ├── di/
│   │ └── itunes_dependency.dart
│   ├── domain/
│   │ ├── entities/
│   │ │ └── track_entity.dart
│   │ ├── repository/
│   │ │ └── itunes_repository.dart
│   │ └── usecase/
│   │   ├── itunes_search_usecase.dart
│   │   └── usecase_params.dart
│   └── presentation/
│     ├── bloc/
│     │ ├── itunes_bloc.dart
│     │ ├── itunes_event.dart
│     │ └── itunes_state.dart
│     ├── pages/
│     │ └── search_view.dart
│     └── widgets/
├── util/
│ ├── dialogs/
│ │ ├── error_dialog.dart
│ │ └── generic_dialog.dart
│ ├── logger.dart
│ └── observer.dart
├── app.dart
├── injection_container.dart
└── main.dart
```
