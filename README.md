# UniSafe

UniSafe is a mobile and web application developed for the University of Dar es Salaam (UDSM) community...

## Features
- Comprehensive solution for addressing gender-based violence on campus
- Counseling and support system
- Collaboration with university authorities
- Social community for students to share experiences

## Prerequisites

1. [Flutter (3.14 or higher)](https://flutter.dev/), can be updated by running `flutter upgrade`
2. git

## Setup

Clone repository

```bash
 git clone https://github.com/FYP-UniSafe/frontend-mobile.git
```

Clear Any Cache

```bash
flutter clean
```

Install all required dependencies for the app

```bash
flutter pub get
```

## Development

Duplicate  .env.example and rename the copied file to .env and add the required values in the .env
```bash
cp .env.example .env
```


1. Add the Google Maps API Key to the [AppDelegate.swift](/ios/Runner/AppDelegate.swift) in the runner folder in the ios directory. Replace `api_key_here` with your API Key

2. Add the Google Maps API Key to the [AndroidManifest.xml](/android/app/src/main/AndroidManifest.xml) in the android app directory. Replace `api_key_here` with your API Key


Run the app on the available emulator/device
```bash
flutter run
```

## Build

After making the changes  we build the application by following the steps below:

Run the following command to build the application for android
```bash
flutter build apk
```

## Contributing
Contributions are welcome. Please follow our guidelines...

## License
This project is licensed under the [MIT License](LICENSE).

## Contact
For inquiries, contact [Reuben William Mollam](mailto:euphoricreuben@gmail.com).