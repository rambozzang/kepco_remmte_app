package com.example.lamp_remote_app

import io.flutter.embedding.android.FlutterActivity
 import android.app.admin.DevicePolicyManager
 import android.bluetooth.BluetoothClass.Device
 import android.content.BroadcastReceiver
 import android.content.Context
 import android.content.Intent
 import android.content.IntentFilter
 import android.os.BatteryManager
 import android.os.Build
 import android.util.Log
 import androidx.annotation.NonNull
 import io.flutter.embedding.engine.FlutterEngine
 import io.flutter.plugin.common.StringCodec
 import io.flutter.plugin.common.BasicMessageChannel
 import io.flutter.plugin.common.EventChannel
 import io.flutter.plugin.common.EventChannel.EventSink
 import io.flutter.plugin.common.MethodChannel
 import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

    
    private lateinit var appLifeCycle: BasicMessageChannel<String>
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
         GeneratedPluginRegistrant.registerWith(flutterEngine)

          appLifeCycle = BasicMessageChannel(
              flutterEngine.dartExecutor.binaryMessenger,
              "appLifeCycle",
              StringCodec.INSTANCE)
          appLifeCycle.setMessageHandler { message, reply ->
              Log.d("AppLifeCycle", "AppLifeCycle Message = $message")
              reply.reply("From Android Life Cycle")
          }
    }
    override fun onResume() {
          super.onResume()
          appLifeCycle.send("lifeCycleStateWithResumed")
    }
    override fun onStop() {
          super.onStop()
          appLifeCycle.send("lifeCycleStateWithStop")
    }
    override fun onRestart() {
          super.onRestart()
          appLifeCycle.send("lifeCycleStateWithRestart")
    }
    override fun onPause() {
       appLifeCycle.send("lifeCycleStateWithInactive")
          super.onPause()
         
    }
    override fun onDestroy() {           
          appLifeCycle.send("lifeCycleStateWithDetached")
          super.onDestroy()
    }

}
