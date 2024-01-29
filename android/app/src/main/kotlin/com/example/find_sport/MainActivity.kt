package com.example.find_sport

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("uz_UZ") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("70983d4d-b02f-4693-a15a-666e9f1034e5") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
