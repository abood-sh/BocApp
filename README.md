# BocApp

A production-ready Flutter application showcasing best practices for mobile development with clean architecture, type-safe API integration, and modern Flutter patterns.

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/abood-sh/BocApp)

## 🚀 Featured Tutorial

**📚 [Retrofit in Flutter - Complete Tutorial](docs/retrofit_tutorial/README.md)**

Learn how to implement type-safe API communication in Flutter using Retrofit. This comprehensive tutorial includes:

- ✅ Step-by-step implementation guide
- ✅ Real-world examples from this project
- ✅ Clean architecture patterns
- ✅ Hands-on exercises with solutions
- ✅ Production-ready code samples
- ✅ LinkedIn sharing templates

[**Start the Tutorial →**](docs/retrofit_tutorial/README.md)

## 🏗️ Architecture

This app demonstrates modern Flutter development patterns:

- **Clean Architecture** - Separation of concerns with clear layers
- **Retrofit Integration** - Type-safe API communication
- **BLoC State Management** - Predictable state handling
- **Dependency Injection** - Loose coupling with GetIt
- **Error Handling** - Comprehensive error management
- **Testing** - Unit and integration test patterns

## 🛠️ Key Features

- **Authentication System** - Secure login/registration flow
- **Home Dashboard** - Specializations and services display
- **Payment Integration** - Stripe payment processing
- **Localization** - Multi-language support
- **Push Notifications** - Firebase Cloud Messaging
- **Offline Support** - Local data persistence

## 📦 Tech Stack

### Core
- **Flutter 3.8.1+** - UI framework
- **Dart** - Programming language

### State Management & Architecture
- **flutter_bloc ^9.1.1** - State management
- **get_it ^8.0.3** - Dependency injection
- **freezed ^2.4.5** - Immutable models

### Networking
- **retrofit ^4.4.2** - Type-safe HTTP client
- **dio ^5.8.0+1** - HTTP client
- **pretty_dio_logger ^1.4.0** - Network logging

### Backend & Storage
- **firebase_core ^3.15.1** - Firebase integration
- **cloud_firestore ^5.6.9** - Cloud database
- **shared_preferences** - Local storage
- **flutter_secure_storage ^9.2.4** - Secure storage

### UI & UX
- **flutter_screenutil ^5.9.3** - Responsive design
- **google_fonts ^6.2.1** - Typography
- **flutter_svg ^2.2.0** - Vector graphics
- **cached_network_image ^3.4.1** - Image caching
- **shimmer ^3.0.0** - Loading animations

### Payment & Security
- **flutter_stripe ^11.5.0** - Payment processing
- **country_picker ^2.0.27** - Country selection

### Localization & Utils
- **easy_localization ^3.0.7+1** - Internationalization
- **timeago ^3.7.1** - Time formatting

## 🚀 Getting Started

### Prerequisites
- Flutter 3.8.1 or higher
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/abood-sh/BocApp.git
   cd BocApp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Set up Firebase**
   - Add your `google-services.json` (Android)
   - Add your `GoogleService-Info.plist` (iOS)

5. **Run the app**
   ```bash
   flutter run
   ```

## 📚 Learning Resources

### Tutorials
- **[Retrofit Tutorial](docs/retrofit_tutorial/README.md)** - Complete guide to API integration
- **[Step-by-Step Examples](docs/retrofit_tutorial/examples/)** - Practical implementations
- **[Exercises](docs/retrofit_tutorial/exercises/)** - Hands-on practice

### Architecture Guides
- Clean Architecture implementation
- BLoC pattern usage
- Dependency injection setup
- Error handling strategies

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](docs/retrofit_tutorial/OVERVIEW.md#contributing) for details.

### Ways to Contribute
- 🐛 Report bugs
- 💡 Suggest features
- 📖 Improve documentation
- 🧪 Add tests
- 🎨 Enhance UI/UX

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Retrofit contributors for type-safe networking
- Open source community for inspiration

---

**Ready to learn Retrofit?** [Start the tutorial →](docs/retrofit_tutorial/README.md)
