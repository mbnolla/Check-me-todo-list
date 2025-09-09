
CheckMe - Todo App 📝
A beautiful and feature-rich Flutter todo application with modern design, state management, and theme switching capabilities.

<img width="624" height="492" alt="image" src="https://github.com/user-attachments/assets/2e981fc5-6cc0-43ce-bcd6-34e90b0fb32b" />
<img width="764" height="413" alt="image" src="https://github.com/user-attachments/assets/ee77d0ab-ff32-4b0d-ba36-bdd053196707" />



✨ Features
🎯 Core Features
User Authentication - Secure login with email validation

Todo Management - Create, read, update, and delete todos

Categories - Organize todos with categories (Personal, Work, School, Urgent, Other)

Due Dates - Set deadlines with overdue indicators

Search & Filter - Find todos quickly with search and filter options

🎨 UI/UX Features
Modern Design - Clean Material Design 3 interface

Theme Switching - Light, Dark, and System theme modes

Responsive Layout - Works on mobile, tablet, and desktop

Smooth Animations - Pleasant user interactions

🔧 Technical Features
Riverpod State Management - Efficient and scalable state management

Local Persistence - Theme preferences saved locally

Form Validation - Robust input validation

Clean Architecture - Well-organized code structure

📱 Screenshots
Login Screen	Home Screen	Add Todo
<img width="624" height="493" alt="image" src="https://github.com/user-attachments/assets/e1ae0466-05c5-4714-9185-1f8144427374" />

Todo Details	Theme Switching	Categories
<img width="624" height="490" alt="image" src="https://github.com/user-attachments/assets/453412f1-8b58-4f4c-a588-32b4192cec14" />
<img width="624" height="489" alt="image" src="https://github.com/user-attachments/assets/55e7faf1-3271-451d-a1f4-582626c9dd06" />


🚀 Getting Started
Prerequisites
Flutter SDK (version 3.0.0 or higher)

Dart (version 2.17.0 or higher)

iOS/Android simulator or physical device

Installation
Clone the repository

bash
git clone https://github.com/your-username/checkme-todo-app.git
cd checkme-todo-app
Install dependencies

bash
flutter pub get
Run the application

bash
flutter run
Building for Production
Android APK:

bash
flutter build apk --release
iOS IPA:

bash
flutter build ipa --release
🏗️ Project Structure
text
lib/
├── models/          # Data models (Todo, User)
├── providers/       # Riverpod state providers
├── screens/         # App screens
├── widgets/         # Reusable widgets
├── utils/           # Utilities and helpers
└── main.dart        # App entry point
🛠️ Technologies Used
Flutter - Cross-platform framework

Riverpod - State management

Shared Preferences - Local storage

Intl - Internationalization and formatting

📦 Dependencies
Key packages used in this project:

yaml
dependencies:
  flutter_riverpod: ^2.4.9
  shared_preferences: ^2.2.2
  intl: ^0.18.1
  cupertino_icons: ^1.0.6
🎨 Theme Customization
The app supports three theme modes:

Light Theme - Bright and clean interface

Dark Theme - Easy on the eyes in low light

System Theme - Follows device theme settings

To customize colors, modify the ThemeData in main.dart.

🔧 Development
Adding New Features
Create models in models/ directory

Add providers in providers/ for state management

Create screens in screens/ for UI

Build reusable widgets in widgets/

Code Style
This project follows:

Dart style guide

Clean architecture principles

Riverpod best practices

🤝 Contributing
We welcome contributions! Please feel free to submit a Pull Request.

Fork the project

Create your feature branch (git checkout -b feature/AmazingFeature)

Commit your changes (git commit -m 'Add some AmazingFeature')

Push to the branch (git push origin feature/AmazingFeature)

Open a Pull Request

📄 License
This project is licensed under the MIT License - see the LICENSE.md file for details.

🙏 Acknowledgments
Flutter team for the amazing framework

Riverpod for excellent state management

Material Design for UI inspiration

📞 Support
If you have any questions or issues, please:

Check the existing issues

Create a new issue with details

Contact the development team

