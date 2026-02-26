package com.example.fatema_mind_glow

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MainActivity : FlutterActivity() {
    companion object {
        private const val ENGINE_ID = "main_engine"
    }
    
    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        // Return cached engine if available for faster startup
        return FlutterEngineCache.getInstance().get(ENGINE_ID)
    }
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Add any custom configurations here
    }
}
