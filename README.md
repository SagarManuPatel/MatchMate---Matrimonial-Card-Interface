MatchMate - Matrimonial Card Interface (iOS)

Overview

MatchMate is a matrimonial iOS app that simulates a matchmaking interface, featuring profile cards. Users can view profiles, accept or decline matches, and the app persistently stores user decisions even in offline mode using Core Data.

* Features :

 - API Integration: Fetches user profiles using https://randomuser.me/api/?results=10.

 - Profile Cards: Displays match cards designed with SwiftUI, showing user details and options to accept or decline.

 - Accept/Decline Functionality: Users can take actions on each card, updating the UI and local database.

 - Local Database: Implements Core Data for offline storage and persistence of user profiles and decisions.

 - Offline Mode: Users can continue interacting with profiles even without an internet connection. The app syncs with the server when the connection is restored.

 - Design Patterns: Utilizes MVVM architecture for separation of concerns and maintainability.

 - Clean UI: Offers a visually appealing interface adhering to iOS design guidelines.

 - Error Handling: Handles errors gracefully for API calls, database operations, and network issues.

* Libraries Used :

 - SwiftUI: For building the user interface.

 - Combine: For handling asynchronous operations and data flow.

 - Core Data: For offline storage and local database management.

* Architecture :

 - MVVM (Model-View-ViewModel):

 - Model: Represents user data (from API or Core Data).

 - View: SwiftUI views for rendering UI components.

 - ViewModel: Manages business logic, API calls, and Core Data interactions.
