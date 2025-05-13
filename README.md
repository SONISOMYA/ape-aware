# 🐵 ApeAware

ApeAware is a Flutter-based mobile application that detects monkey intrusions using a YOLOv8 model and sends real-time alerts via Firebase Cloud Messaging (FCM). The app is designed for campus and residential security, offering:

-  Smart monkey detection (YOLOv8)
-  Instant push notifications on monkey detection
-  Firestore integration to log detection data
-  Call functionality for quick action

##  Tech Stack

- Flutter (Frontend)
- Firebase Firestore & FCM (Backend)
- YOLOv8 (Machine Learning - Colab)
- OpenCV & Python (Detection Pipeline)

##  Setup Instructions

1. Clone the repo
2. Run `flutter pub get`
3. Connect to Firebase (Firestore + Messaging)
4. Deploy YOLOv8 model on Colab or server
5. Run the app on an Android/iOS device

##  Folder Structure

- `lib/` – Flutter app source code
- `model/` – YOLOv8 training setup (Colab)
- `firebase/` – Firebase setup and credentials (not included in repo)



Made with ❤️ for a Minor Project @ JUIT
