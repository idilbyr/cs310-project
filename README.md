# FridgeNote

FridgeNote is a mobile application designed to help households track their food inventory through a shared digital space. By providing a structured database for product details like brand names and usage dates, it helps multiple stakeholders manage a single fridge efficiently.

## Group Members

*   Idil Bayar / 32267
*   Taha Yusa Bayraktar / 32398
*   Furkan Cetin / 32384
*   Berkan Cetin / 32055
*   Semih Kas / 22575
*   Alp Mert Eksi / 32119

## The Problem

In the twenty-first century, consumption is a term that dominates our lives. Having access to a vast amount of different and exotic products and being able to store these products in our house enabled us to buy products without thinking thoroughly about them. Increasing house expenses force people to rent a flat with their friends or continue to live with their parents. This results in multiple people sharing the same fridge in their apartments, dorms, or even in the workplace.

This shareholding raises a certain problem: How do we track this mindless shopping of each member who has access to our fridge? If we do not track what is bought, there is a huge possibility that the same product can be bought again. Having the redundant necessity to look in the fridge and memorize everything inside is not a feasible solution. FridgeNote aims to resolve this dilemma and create an easy, user-friendly space to keep track of fridges in the modern era.

## Features

### Core Features

*   **Multiple User Interaction:** Multiple users can access the same virtual fridge data.
*   **Multi-Fridge Support:** One user can create and manage several fridges (e.g., Home, Office).
*   **Categories:** Inventory is divided into Fruit, Vegetable, Meat, Dairy, and Fish.
*   **Detailed Database:** Stores product name, brand, amount (SI units), expiration date, and custom notes.
*   **Virtual Shopping List:** A real-time list to notify members of items that need to be purchased.

### Additional Features

*   **Expiration Alerts:** A color-coded system tracks how close products are to their expiration date.
*   **Search Functionality:** Ability to search for specific items within fridge categories.
*   **Theme Toggle:** Users can switch between light and dark mode in the "About" page.

## Technical Details

### Firebase Integration

The application uses Firebase for two primary purposes:
*   **Authentication:** Manages secure user login, registration, and password resets.
*   **Cloud Firestore:** Acts as the NoSQL database to store fridge contents and shopping lists in real-time.

### State Management

The project uses an asynchronous data-binding approach. The UI is connected to Firestore using listeners, ensuring that when one user updates the fridge or shopping list, the changes appear instantly on other users' devices.

## Setup and Run Instructions

### Prerequisites

*   Flutter SDK (Version 3.x or higher)
*   Android Studio or VS Code with Flutter/Dart plugins
*   A Firebase project with Firestore and Auth enabled

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/your-username/FridgeNote.git
    ```
2.  Navigate to the project folder and install dependencies:
    ```bash
    cd FridgeNote
    flutter pub get
    ```
3.  Add your Firebase configuration files:
    *   Place `google-services.json` in `android/app/`
    *   Place `GoogleService-Info.plist` in `ios/Runner/`
4.  Run the application:
    ```bash
    flutter run
    ```

## How to Run Tests

To execute the automated unit tests for the application, use the following command:
```bash
flutter test