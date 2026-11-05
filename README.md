# KNOWME PUBG — starter project

Flutter starter for Android and iOS. Theme: black + red.

## Included
- Home dashboard
- Sensitivity sliders (Camera, ADS, Gyroscope)
- Local 30-second tap-target aim practice
- Premium information screen (no real billing wired up)
- Local player profile preview

## Run
1. Install Flutter and Android Studio / Flutter SDK.
2. Extract this folder.
3. Run `flutter pub get`
4. Run `flutter run`

## Build Android
`flutter build apk --release`

## Build iOS
`flutter build ios --release` must be run in a macOS environment with Xcode configured.
A cloud macOS CI runner can be used if you do not own a Mac.

## Important
This is a starter app, not a finished commercial release. Profile persistence, cloud accounts,
analytics, privacy policy, store billing, testing, and store publishing still need implementation.
It does not modify PUBG Mobile or interact with the game process.
