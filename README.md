# flutter-todo-app-tasks-management

<h1> Don't Forget To Add This Lines To "android/app/src/main/AndroidManifest"</h1>
    <!-- Permission Notification-->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    
    <!-- Permission To Use Audio -->
    <uses-permission android:name="android.permission.INTERNET"/>

    <!-- 1. Permission -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <h3>And</h3>
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
