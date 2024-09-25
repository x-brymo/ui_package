# [FirebaseNotificationsHandler](https://pub.dev/packages/firebase_notifications_handler) For Flutter
[![pub package](https://img.shields.io/pub/v/firebase_notifications_handler.svg)](https://pub.dev/packages/firebase_notifications_handler)
[![likes](https://img.shields.io/pub/likes/firebase_notifications_handler)](https://pub.dev/packages/firebase_notifications_handler/score)
[![popularity](https://img.shields.io/pub/popularity/firebase_notifications_handler)](https://pub.dev/packages/firebase_notifications_handler/score)
[![pub points](https://img.shields.io/pub/points/firebase_notifications_handler)](https://pub.dev/packages/firebase_notifications_handler/score)
[![code size](https://img.shields.io/github/languages/code-size/rithik-dev/firebase_notifications_handler)](https://github.com/rithik-dev/firebase_notifications_handler)
[![license MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

* Simple notifications handler which provides callbacks like onTap which really make it easy to handle notification taps and a lot more.
* The package already handles local notifications so notifications are rendered in every case without any additional setup, however overrides are available if required.

## Screenshots
<img src="https://github.com/user-attachments/assets/6a55461d-0abb-4275-bc0d-389b3fb81644" height=500/>&nbsp;&nbsp;<img src="https://github.com/user-attachments/assets/f85f3012-7566-4692-bc5e-6ce47f1681b4" height=500/>&nbsp;&nbsp;<img src="https://github.com/user-attachments/assets/f2794bb4-2f93-4dd1-9aab-d9f393917606" height=200/>&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/56810766/123861270-9a9e4800-d944-11eb-8c04-8fd3e9557876.png" height=600/>&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/56810766/123926531-96f0dc80-d9a9-11eb-85e4-eee661baaffd.jpeg" height=600/>&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/56810766/166269612-d555f82c-1634-4431-8ea4-619120e87815.png" height=600/>


## Migration Guide from v1.x to v2.x+ ([Full Changelog](https://github.com/rithik-dev/firebase_notifications_handler/blob/master/CHANGELOG.md#200---23092024))

* Numerous parameters were renamed to add clarity and consistency, and some were removed. Refer to the [CHANGELOG.md](https://github.com/rithik-dev/firebase_notifications_handler/blob/master/CHANGELOG.md#200---18032023) for more details.
* Removed Constants class and added LocalNotificationsConfiguration class which holds android and ios specific configs for local notifications, and takes default values from firebase message, but these parameters can be overwritten by passing in values in the function getters.
* NavigatorKey is no longer accepted/provided in the onTap, onOpenNotificationArrive callbacks. Instead, you'll have to create a key and maintain it in your app. Refer to the [example app](https://github.com/rithik-dev/firebase_notifications_handler/tree/master/example).
* Moved android-specific local notifications config params like channelId, channelName, sound etc. from Constants to localNotificationsConfiguration.androidConfig.
* Moved ios-specific local notifications config params like sound etc. to localNotificationsConfiguration.iosConfig.
* onFCMTokenRefresh is removed. Instead, you can use onFcmTokenUpdate callback. You can always maintain your own stream for tokens in your app if needed.
* NotificationTapDetails class is now called NotificationInfo, and NotificationInfo now also holds the firebase message as a parameter.
* onOpenNotificationArrive now provides an object of NotificationInfo instead of just the payload. The payload can be accessed simply by using `payload` property of this class.
* notificationArrivesSubscription now returns a Stream of NotificationInfo objects instead of just the payload.
* notificationIdGetter moved to localNotificationsConfiguration.notificationIdGetter

## Getting Started
<b>Step 1</b>: Before you can add Firebase to your app, you need to create a Firebase project to connect to your application.
Visit [`Understand Firebase Projects`](https://firebase.google.com/docs/projects/learn-more) to learn more about Firebase projects.

<b>Step 2</b>: To use Firebase in your app, you need to register your app with your Firebase project.
Registering your app is often called "adding" your app to your project.

Also, register a web app if using on the web.
Follow on the screen instructions to initialize the project.

Add the latest version 'firebase-messaging' CDN from [here](https://firebase.google.com/docs/web/setup#available-libraries) in index.html.
(Tested on version 8.6.1)

<b> Step 3</b>: Add a Firebase configuration file and the SDK's. (google-services)

<b> Step 4</b>: Lastly, add [`firebase_core`](https://pub.dev/packages/firebase_core) as a dependency in your pubspec.yaml file.
and call `Firebase.initializeApp()` in the `main` method as shown:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(_MainApp());
}
```

### Android

Add the default channel in AndroidManifest in the `<application>` tag. Pass the same in the channelId parameter in the
`FirebaseNotificationsHandler` widget to enable custom sounds.

```xml
<meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="Notifications" />
```
The `android:value` should be the same as the channel id in FirebaseNotificationsHandler.
The default value for channel id is "Notifications".


Also, add this intent-filter in AndroidManifest in the `<activity>` tag with `android:name=".MainActivity"`
```xml
<intent-filter>
    <action android:name="FLUTTER_NOTIFICATION_CLICK" />
    <category android:name="android.intent.category.DEFAULT" />
</intent-filter>
```

### Web
Provide the vapidKey in FirebaseNotificationsHandler from the cloud messaging settings by generating
a new Web push certificate

Add this script tag in index.html after adding the firebase config script
```html
<script>
if ("serviceWorker" in navigator) {
  window.addEventListener("load", function () {
    // navigator.serviceWorker.register("/flutter_service_worker.js");
    navigator.serviceWorker.register("/firebase-messaging-sw.js");
  });
}
</script>
```

Now, finally create a file `firebase-messaging-sw.js` in the `web` folder itself
and paste the following contents. Add your own firebase app config here.

```js
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

firebase.initializeApp(
    // YOUR FIREBASE CONFIG MAP HERE
);

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});
```

## Custom Sound
#### Adding custom notification sounds in Android
- Add the audio file in android/app/src/main/res/raw/___audio_file_here___
- Add the audio file name in the `soundGetter` parameter in the `AndroidConfig` class.

Add a [keep.xml](https://github.com/rithik-dev/firebase_notifications_handler/tree/master/example/android/app/src/main/res/raw/keep.xml) file in the raw folder for Android, as during compilation, flutter strips off the raw folder, and the custom sounds won't work in release mode

#### Adding custom notification sounds in iOS
- Add the audio file in Runner/Resources/___audio_file_here___
- Add the audio file name in the `soundGetter` parameter in the `IosConfig` class.



## Usage

To use this plugin, add [`firebase_notifications_handler`](https://pub.dev/packages/firebase_notifications_handler) as a dependency in your pubspec.yaml file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
    firebase_notifications_handler:
```

First and foremost, import the widget.
```dart
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
```

Wrap the `FirebaseNotificationsHandler` on a widget to enable your application to receive notifications.
Typically wrap it on the screen, when you have all the initial setup done. (like on the home screen).

When the app launches, the splash screen typically loads all the stuff, initializes the users and 
sends to the home screen, then the onTap will trigger, and can be handled accordingly from the callback.

If wrapped on the material app, then you might push the user to the specified screen too early,
before initializing the user or something that you need.
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebaseNotificationsHandler(
      child: HomeScreen(),
    );
  }
}
```

Disabling logs: You can set the `enableLogs` parameter to false to disable the logs.
```dart
FirebaseNotificationsHandler.enableLogs = false;
```

Although, the widget automatically initializes the fcmToken, but if the FCM token is needed before the widget is built,
then use the `initializeFcmToken()` function to initialize the token. Which will return the initialized token.

Also, keep in mind, when the widget is built, the onFCMTokenInitialize callback will also fire, with the same token.

There are multiple parameters that can be passed to the widget, some of them are shown.
```dart
FirebaseNotificationsHandler(
    onFcmTokenInitialize: (token) => fcmToken = token,
    onFcmTokenUpdate: (token) {
        fcmToken = token;
        // await User.updateFCM(token);
    },
    onTap: (details) {
        final appState = details.appState;
        final payload = details.payload;
      
        print("Notification tapped with $appState & payload $payload");

        final context = Globals.navigatorState.currentContext!;
        Globals.navigatorState.currentState!.pushNamed('newRouteName');
        // OR
        Navigator.pushNamed(context, 'newRouteName');
    },
    localNotificationsConfiguration: LocalNotificationsConfiguration(
        androidConfig: AndroidNotificationsConfig(
          channelIdGetter: (msg) => msg.notification?.android?.channelId ?? 'default',
        ),
    ),
    // ... and a lot more
),
```

You can check the remaining parameters [here](https://github.com/rithik-dev/firebase_notifications_handler/blob/master/lib/src/widget.dart).
They are fully documented and won't face an issue while using them

## Steps to test the example app

To test the example app, clone the project and replace the [firebase_options.dart](https://github.com/rithik-dev/firebase_notifications_handler/blob/master/example/lib/firebase_options.dart) with your firebase project.

Then, build an apk and run it. The app is set to receive notifications.

### To Send Notifications

#### Using Firebase Console
Open the [Firebase Console](https://console.firebase.google.com/), and then go to Build > Messaging from the left panel. Choose Create first campaign, and then Firebase notification message,
put in the title, body and image (if any), and then press Send test message, paste the FCM token which you can get by running the example app and copy it from there, and then send the notification.

#### Using Node Project
To send notifications using a node project, clone this [notification-sender](https://github.com/rithik-dev/notification-sender) project,

Download the service account key file by visiting the [Google Cloud Service Accounts Panel](https://console.cloud.google.com/iam-admin/serviceaccounts/) and select the correct project, and add a new key or use an existing one if you already have.

You should now have the project id, client email and the private key from the json key file, and create a .env file in the [root folder](https://github.com/rithik-dev/notification-sender/tree/main). Add keys `FIREBASE_PROJECT_ID`, `CLIENT_EMAIL` and `PRIVATE_KEY` in the .env file.

Now copy the fcm token from the running example app, and pass it to the [index.ts](https://github.com/rithik-dev/notification-sender/blob/main/src/index.ts) file in the `fcm_tokens` array,
and run `npm start`.

## Debugging common issues
#### Notification not showing as a pop up on Android device: 
###### On Android devices, a notification channel by default when a notification arrives, but that might not have the priority set to high. The notification only shows up as a popup if the channel you're sending it to has priority set as "high". We can solve this issue by creating a notification channel on app start using:
```dart
FirebaseNotificationsHandler.createAndroidNotificationChannel(
  const AndroidNotificationChannel(
    'Notifications',
    'Notifications',
    importance: Importance.high,
  ),
);
```

#### Custom sound not playing when notification received on Android device:
###### On Android devices, a notification channel by default when a notification arrives, but that won't have the sound set to it by default. The sound will only play if the channel was creating while specifying the custom sound you want to play for that channel. We can solve this issue by creating a notification channel on app start and passing in the sound using:
```dart
FirebaseNotificationsHandler.createAndroidNotificationChannel(
  const AndroidNotificationChannel(
    'Notifications',
    'Notifications',
    playSound: true,
    importance: Importance.high,
    sound: RawResourceAndroidNotificationSound('custom_sound'),
  ),
);
```
###### PS: You cannot modify a channel's sound after it's created. Only way is to either use a new channel id or delete an existing channel using `FirebaseNotificationsHandler.deleteAndroidNotificationChannel(String channelId);` and creating a new one with the new sound. Or try uninstalling the app and creating the channel again.


#### Notification image not showing if app in background or terminated even when passed on Android device:
###### The max size for a notification to be displayed by firebase on an Android device is 1MB ([Source](https://firebase.google.com/docs/cloud-messaging/android/send-image#:~:text=Images%20for%20notifications%20are%20limited,by%20native%20Android%20image%20support.)). So, if an image exceeds this size, it is not shown in the notification. However, if the app is in foreground, then there is no size limitation as then it's handled by local notifications.

#### Custom sounds in Android work in debug mode but not in release mode
###### Flutter strips off the `raw` folder during compiling build for release mode. We can add a file [keep.xml](https://github.com/rithik-dev/firebase_notifications_handler/tree/master/example/android/app/src/main/res/raw/keep.xml) in the raw folder, which tells flutter to not strip off the raw folder, and hence fixing the issue.

## Sample Usage
```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/material.dart';
import 'package:notifications_handler_demo/firebase_options.dart';
import 'package:notifications_handler_demo/screens/splash_screen.dart';
import 'package:notifications_handler_demo/utils/app_theme.dart';
import 'package:notifications_handler_demo/utils/globals.dart';
import 'package:notifications_handler_demo/utils/helpers.dart';
import 'package:notifications_handler_demo/utils/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const _MainApp());
}

class _MainApp extends StatelessWidget {
  static const id = '_MainApp';

  const _MainApp();

  @override
  Widget build(BuildContext context) {
    return FirebaseNotificationsHandler(
      localNotificationsConfiguration: LocalNotificationsConfiguration(
        androidConfig: AndroidNotificationsConfig(
          channelIdGetter: (msg) => msg.notification?.android?.channelId ?? 'default',
        ),
        iosConfig: IosNotificationsConfig(
          soundGetter: (_) => 'ios_sound.caf',
        ),
      ),
      shouldHandleNotification: (msg) {
        // add some logic and return bool on whether to handle a notif or not
        return true;
      },
      onOpenNotificationArrive: (info) {
        // final context = Globals.navigatorKey.currentContext!;

        log(
          id,
          msg: "Notification received while app is open with payload ${info.payload}",
        );
      },
      onTap: (info) {
        final payload = info.payload;
        final appState = info.appState;

        /// If you want to push a screen on notification tap
        ///
        // Globals.navigatorKey.currentState?.pushNamed(
        //   payload['screenId'],
        // );
        ///
        /// or
        ///
        /// Get current context
        // final context = Globals.navigatorKey.currentContext!;

        log(
          id,
          msg: "Notification tapped with $appState & payload $payload",
        );
      },
      onFcmTokenInitialize: (token) => Globals.fcmTokenNotifier.value = token,
      onFcmTokenUpdate: (token) => Globals.fcmTokenNotifier.value = token,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FirebaseNotificationsHandler Demo',
        navigatorKey: Globals.navigatorKey,
        scaffoldMessengerKey: Globals.scaffoldMessengerKey,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
```

See the [`example`](https://github.com/rithik-dev/firebase_notifications_handler/blob/master/example) directory for a complete sample app.

### Created & Maintained By `Rithik Bhandari`

* GitHub: [@rithik-dev](https://github.com/rithik-dev)
* LinkedIn: [@rithik-bhandari](https://www.linkedin.com/in/rithik-bhandari/)