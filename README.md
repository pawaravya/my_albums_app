# My Album App

A Flutter app that lists albums fetched from an API, with search functionality, recent searches, and offline storage of recent searches. Built using MVVM architecture and GetX for state management.

# Features

Fetch and display a list of albums with titles and thumbnails.

Search albums by title using the keyboard search action.

Store recent searches locally using SharedPreferences.

Reactive state management using GetX.

Exit confirmation dialog when pressing the back button.

Image loading uses CachedNetworkImage with placeholders and error handling.

Known Issue: Images may not load because of backend URL issues.

# Architecture

The app follows the MVVM pattern:

Model: Album model represents API responses.

View: AlbumListScreen displays albums and search functionality.

ViewModel: AlbumViewModel handles state, API calls, search logic, and recent searches.

#  Getting Started
Prerequisites

Flutter 3.16+

Dart 3+

# Installation

Clone the repository:

git clone https://github.com/pawaravya/my_albums_app.git


Navigate to the project folder:

cd my_movies


Install dependencies:

flutter pub get

Running the App
flutter run

Packages Used

get: State management and reactive UI

cached_network_image: Efficient image loading with placeholders

shared_preferences: Local storage for recent searches

Notes

All static strings are stored in StringConstants.

Recent searches are stored locally using AppSharedPreferences.

The exit confirmation dialog i![1756477261573](https://github.com/user-attachments/assets/fcb25cf6-aacb-4797-bcef-0df8ecad1088)
s implemented in the main album listing screen.

The search functionality updates recent searches only when the search action is submitted.

Image loading may fail if the backend URLs are not valid.

# screenshots

![1756477261570](https://github.com/user-attachments/assets/884a8ed7-24ef-4460-90fc-ee6ca62d4b1d)
![1756477261573](https://github.com/user-attachments/assets/caa50190-d810-4e89-8bd7-84c44c76340f)
![1756477261586](https://github.com/user-attachments/assets/9941b990-7c1b-4df7-ae42-09651d7d1b35)
![1756477261576](https://github.com/user-attachments/assets/ce6933f9-0f8b-4625-bda0-7218ab28323c)
![1756477261581](https://github.com/user-attachments/assets/eedbccef-46cb-45a7-bfe9-60e94e5b3759)





