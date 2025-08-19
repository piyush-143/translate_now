# Keep the missing Chinese Text Recognizer classes.
-keep class com.google.mlkit.vision.text.chinese.** { *; }

# Keep the missing Japanese Text Recognizer classes.
-keep class com.google.mlkit.vision.text.japanese.** { *; }

# Keep the missing Korean Text Recognizer classes.
-keep class com.google.mlkit.vision.text.korean.** { *; }

# Keep the missing Devanagari Text Recognizer classes.
-keep class com.google.mlkit.vision.text.devanagari.** { *; }

# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.mlkit.vision.text.chinese.ChineseTextRecognizerOptions$Builder
-dontwarn com.google.mlkit.vision.text.chinese.ChineseTextRecognizerOptions
-dontwarn com.google.mlkit.vision.text.devanagari.DevanagariTextRecognizerOptions$Builder
-dontwarn com.google.mlkit.vision.text.devanagari.DevanagariTextRecognizerOptions
-dontwarn com.google.mlkit.vision.text.japanese.JapaneseTextRecognizerOptions$Builder
-dontwarn com.google.mlkit.vision.text.japanese.JapaneseTextRecognizerOptions
-dontwarn com.google.mlkit.vision.text.korean.KoreanTextRecognizerOptions$Builder
-dontwarn com.google.mlkit.vision.text.korean.KoreanTextRecognizerOptions