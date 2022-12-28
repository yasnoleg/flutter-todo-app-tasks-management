# flutter-todo-app-tasks-management

<h3> Don't Forget To Add This Lines To "android/app/src/main/AndroidManifest"</h3>
    <!-- Permission Notification-->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    
    <!-- Permission To Use Audio -->
    <uses-permission android:name="android.permission.INTERNET"/>

    <!-- 1. Permission -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    
    <application
        ...
        android:usesCleartextTraffic="true">
      <activity
            ...
            <meta-data
              android:name="com.google.firebase.messaging.default_notification_channel_id"
              android:value="chaid" />
            <intent-filter>
                <action android:name="FLUTTER_NOTIFICATION_CLICK"/>
                <category android:name="android.intent.category.DEFAULT"/>
            </intent-filter>
            ...
    </application>

## Features

- add daily task and receive notification when the start time of your task comes
- manage your projects 
- beautiful Ui
- smooth animation
- provide the users with opportunity to see there daily advancement 
