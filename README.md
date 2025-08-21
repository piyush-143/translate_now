# Translate Now - Your Instant Language Translator App

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Google](https://img.shields.io/badge/Google-4285F4?style=for-the-badge&logo=google&logoColor=white)](https://google.com)
[![Provider](https://img.shields.io/badge/Provider-%234DB6AC.svg?style=for-the-badge&logoColor=white)](https://pub.dev/packages/provider)
[![sqflite](https://img.shields.io/badge/sqflite-%2300897B.svg?style=for-the-badge&logoColor=white)](https://pub.dev/packages/sqflite)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue.svg)](https://flutter.dev/docs/get-started/install)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/your-username/translate_now/pulls)
[![Issues](https://img.shields.io/github/issues/your-username/translate_now)](https://github.com/your-username/translate_now/issues)

**Translate Now** is a modern and intuitive Flutter application designed to break down language barriers. Instantly translate text, spoken words, and even images, all within a sleek and responsive user interface. Using **Provider** for efficient state management, **sqflite** for persistent local storage, and a robust translation API, Translate Now provides a seamless and reliable solution for all your translation needs.

---

## 📸 Screenshots

<img src="https://github.com/user-attachments/assets/4e63569f-0bb0-4246-8f43-4228bd261c18" data-canonical-src="https://github.com/user-attachments/assets/4e63569f-0bb0-4246-8f43-4228bd261c18" width="180" height="340" />
<img src="https://github.com/user-attachments/assets/a67d31f2-859f-43d7-8b93-06540d3276ed" data-canonical-src="https://github.com/user-attachments/assets/a67d31f2-859f-43d7-8b93-06540d3276ed" width="180" height="340" />
<img src="https://github.com/user-attachments/assets/ab05c1e5-f5b6-4e81-9db1-71f58585027e" data-canonical-src="https://github.com/user-attachments/assets/ab05c1e5-f5b6-4e81-9db1-71f58585027e" width="180" height="340" />
<img src="https://github.com/user-attachments/assets/9aed083f-0eb0-4ee6-84d6-d61befbe01fd" data-canonical-src="https://github.com/user-attachments/assets/9aed083f-0eb0-4ee6-84d6-d61befbe01fd" width="180" height="340" />
<img src="https://github.com/user-attachments/assets/230ad97f-c759-4f1f-bc99-40247ead115a" data-canonical-src="https://github.com/user-attachments/assets/230ad97f-c759-4f1f-bc99-40247ead115a" width="180" height="340" />
<img src="https://github.com/user-attachments/assets/4c0e4798-5eb0-4934-af14-3ebee406415f" data-canonical-src="https://github.com/user-attachments/assets/4c0e4798-5eb0-4934-af14-3ebee406415f" width="180" height="340" />
<img src="https://github.com/user-attachments/assets/7ebf86cd-ef91-4d93-9d97-5b51435276e6" data-canonical-src="https://github.com/user-attachments/assets/7ebf86cd-ef91-4d93-9d97-5b51435276e6" width="180" height="340" />
<img src="https://github.com/user-attachments/assets/361d1ea6-291e-44a1-9cb7-f7b1175f2b3a" data-canonical-src="https://github.com/user-attachments/assets/361d1ea6-291e-44a1-9cb7-f7b1175f2b3a" width="180" height="340" />

---


## ✨ Highlighted Features

* **Real-time Text Translation:** Get instant translations as you type. **Translate Now** provides fast and accurate text translations for multiple languages, making conversations and reading foreign texts effortless.
* **Speech-to-Speech Translation:** Speak into your device and have your words translated and spoken aloud in the target language. This feature is perfect for real-time conversations and travel.
* **Image Translation:** Snap a picture of a sign, menu, or document, and the app will instantly translate the text within the image. This powerful feature uses OCR (Optical Character Recognition) to extract text and provide a quick translation.
* **Favourites and History:** Easily save your most frequent translations to your favourites list for quick access. The app also keeps a comprehensive history of all your translations, allowing you to revisit and reuse them whenever needed.
* **Offline Mode:** Select languages can be downloaded for offline use, ensuring you can translate even without an internet connection. This is an essential feature for travellers in areas with limited connectivity.

---

## 🛠️ Technologies Used

* **Flutter:** A powerful UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
* **Provider:** A simple, testable, and widely adopted state management solution for Flutter applications.
* **sqflite:** A Flutter plugin providing SQLite database access, enabling robust local data storage.
* **path_provider:** A Flutter plugin for finding common locations on the device's file system, necessary for initialising the sqflite database.
* **google_ml_kit:** A library for handling API calls to a translation service, ensuring accurate and efficient translations.
* **speech_to_text:** A Flutter plugin for converting spoken language to text.
* **image_picker:**  A Flutter package for picking images from the device's gallery or taking new ones with the camera.

---

## 🚦 State Management (Provider)

**Translate Now** leverages the **Provider** package to manage the application's state cleanly and efficiently. The `TranslationProvider` is at the core of the app's functionality:

* Manages the state of the source and target languages.
* Handles the translation logic, including API calls and error handling.
* Provides methods to add and remove translations from the favourites list.
* Ensures that UI components automatically update when a new translation is completed or a favourite is added.

---

## 💾 Local Data Storage (sqflite)

The **sqflite** plugin is employed for persistent local storage of the translation history and favourites. The `DatabaseHelper` class encapsulates all database interactions, including:

* Initialising and managing the SQLite database instance.
* Defining the schema for the `translation_history` and `favourites` tables.
* Implementing CRUD (Create, Read, Update, Delete) operations for managing translation records.

---

## 🤝 Contributing

We welcome contributions from the community! If you have ideas for new features, bug fixes, or improvements, please feel free to:

1.  Fork the repository.
2.  Create a new branch for your feature or fix.
3.  Implement your changes and write appropriate tests.
4.  Commit your changes following conventional commit guidelines.
5.  Push your branch to your forked repository.
6.  Submit a pull request detailing your changes.

Please ensure your code adheres to the project's coding standards and that your pull request clearly describes the issue or feature you are addressing.

---

## 🙏 Acknowledgements

* The Flutter team for providing an excellent cross-platform development framework.
* The developers and maintainers of all the valuable Flutter packages used in this project.
* The team behind the translation API for providing a robust and reliable service.
