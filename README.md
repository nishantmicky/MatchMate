# MatchMate

## 👋 Introduction
MatchMate is an iOS application developed in SwiftUI that simulates a matrimonial app by displaying match cards. Users can accept or decline matches, the app will store and display decisions persistently even in offline mode.

- Language used: Swift
- UI: SwiftUI
- Design pattern used: MVVM
- Storage: Core Data
- Image download: SDWebImage framework
- This app uses API endpoint `https://randomuser.me/api/?results=10` to fetch user data to populate match cards.
- The match cards includes user image, basic details and two action button - accept and decline.
- When user taps accept/decline button, it updates the card UI to show member accepted/rejected.
- This app stores user profiles and their acceptance/decline status in Core Data.
- This app uses SDWebImage to download and fetch image to run app in offline mode also.
- This app also works in offline mode, cached data in core data is displayed when user is offline.
- User can also accept/decline even without internet connection.
- This app also handles error for API calls, database operation and network connectivity.
- Screenshot: 
![Simulator Screenshot - iPhone 16 Pro - 2025-03-02 at 22 32 03](https://github.com/user-attachments/assets/7052e7cb-862f-47a4-8f2d-94f6c7ef9cfb)

