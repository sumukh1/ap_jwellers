# Application Blueprint

## Overview

This application is a Flutter project with various features including authentication, categories, gifts, eGold, and a profile section. The UI is built using custom widgets and a predefined color scheme. The application uses `go_router` for navigation and `provider` for state management.

## Styles, Design, and Features

*   **Styling:** The application uses a consistent theme with `ColorScheme.fromSeed` and custom widgets for common UI elements. `AppColors` from `lib/static/AppColors.dart` are used for the color scheme.
*   **Navigation:** `go_router` is used for declarative navigation.
*   **Authentication:** Includes pages for getting started, login, signup, and verification.
*   **Features:** Categories, Gifts, EGold, and You (profile) sections are implemented.

## Plan for Adding Cart, Order Success, and Order Track Pages

This plan outlines the steps to add three new pages: Cart, Order Success, and Order Track.

1.  **Create Page Files:**
    *   Create `lib/features/cart/presentation/pages/cart_page.dart`
    *   Create `lib/features/order_success/presentation/pages/order_success_page.dart`
    *   Create `lib/features/order_track/presentation/pages/order_track_page.dart`
2.  **Add Routes:** Add routes for `CartPage`, `OrderSuccessPage`, and `OrderTrackPage` in `lib/routes.dart`.
3.  **Implement UI:**
    *   Implement the UI for each page using custom widgets and `AppColors`.
    *   For the Cart page, include widgets to display cart items, quantity selectors, and a checkout button.
    *   For the Order Success page, display a success message and order summary.
    *   For the Order Track page, show order status and details.
