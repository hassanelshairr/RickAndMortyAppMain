# Rick and Morty iOS App

An iOS application built using **Swift, UIKit, SwiftUI, and MVVM (Clean Architecture)** to display characters from the Rick and Morty API with filtering and pagination.

---

## 🚀 Features
- List of characters fetched from the [Rick & Morty API](https://rickandmortyapi.com/).
- Filter characters by status (Alive, Dead, Unknown).
- Pagination support (load 20 characters at a time, fetch next 20 when reaching the end).
- Mix of **UIKit** and **SwiftUI** (via `UIHostingController`) for UI flexibility.
- Unit tested ViewModel layer.

---

## 🛠 Requirements
- Xcode 15+
- iOS 16+
- Swift 5+

---

## 📦 Installation & Running
1. Clone the repository:
   ```bash
   git clone https://github.com/hassanelshairr/RickAndMortyAppMain.git
   cd rickandmorty-ios

2. Open RickAndMortyApp.xcodeproj in Xcode.
3. Select an iOS simulator (e.g., iPhone 15 Pro).
4. Run the project (Cmd + R).


---

## 📦 Assumptions & Decisions

- Used **SwiftUI** for UI filters and UIKit `UITableView` for the character list, to demonstrate integration between the two frameworks.  
- Pagination is implemented with a simple **page counter** (20 items per page). When the user scrolls to the bottom, the next page is automatically requested.  
- The app follows **Clean Architecture** principles, separating concerns into:
  - **Domain Layer** → Use Cases  
  - **Data Layer** → API & Repository  
  - **Presentation Layer** → ViewModels + Views / ViewControllers  

---
📸 Screenshots

<img width="1179" height="2556" alt="Simulator Screenshot - Clone 1 of iPhone 16 - 2025-08-28 at 13 40 01" src="https://github.com/user-attachments/assets/26bb8c10-36de-4468-9940-6c7b2d02ca61" />

<img width="1179" height="2556" alt="Simulator Screenshot - Clone 1 of iPhone 16 - 2025-08-28 at 13 39 57" src="https://github.com/user-attachments/assets/b94f4e61-65ac-4482-a45d-cd0feb13c5b2" />

<img width="1179" height="2556" alt="Simulator Screenshot - Clone 1 of iPhone 16 - 2025-08-28 at 13 40 13" src="https://github.com/user-attachments/assets/8f45a6aa-91fc-4e00-89a2-28ce889f9a09" />

<img width="1024" height="1024" alt="ChatGPT Image Aug 28, 2025 at 02_08_07 PM" src="https://github.com/user-attachments/assets/19ec4b7d-dc93-4d4a-a4cb-f078beb165cd" />




