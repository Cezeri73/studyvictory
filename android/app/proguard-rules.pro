# ProGuard Rules for StudyVictory
# Flutter and Dart specific rules

# Keep Flutter wrapper classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep native method names for reflection
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep SharedPreferences classes
-keep class androidx.preference.** { *; }
-keepclassmembers class * extends androidx.preference.Preference {
    <init>(...);
}

# Keep serialization classes
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions

# Keep JSON serialization classes (for SharedPreferences data)
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep parcelable classes
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator CREATOR;
}

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# URL Launcher
-keep class androidx.browser.** { *; }

# Keep Chart library (fl_chart)
-keep class com.github.PhilJay.** { *; }

# Prevent obfuscation of native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Flutter embedding
-keep class io.flutter.embedding.** { *; }

