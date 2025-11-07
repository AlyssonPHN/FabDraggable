# Draggable FAB and Popup

This is a sample Flutter project that demonstrates a draggable Floating Action Button (FAB) which, when tapped, transforms into a popup dialog. The popup allows the user to write and send a message.

## Features

*   **Draggable Floating Action Button:** The FAB can be moved around the screen.
*   **Hero Animation:** A smooth transition from the FAB to the popup.
*   **Shake Animation:** The popup shakes if the user tries to send an empty message.
*   **Bloc for State Management:** The FAB's position is managed using the `flutter_bloc` package.

## How to Run

1.  Clone this repository.
2.  Make sure you have the Flutter SDK installed.
3.  Run `flutter pub get` to install the dependencies.
4.  Run `flutter run` to build and run the app on your connected device or emulator.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── shared/
│   ├── components/
│   │   ├── float_button_draggable/
│   │   │   ├── controller/
│   │   │   │   └── fab_floating_controller.dart  # BLoC state management for the FAB
│   │   │   └── float_button_draggable.dart       # The draggable FAB widget
│   │   └── flying_letter_popup/
│   │       └── flying_letter_popup.dart        # The popup dialog and its animations
│   └── constants/
│       └── Dimens.dart             # App dimensions
...
```
