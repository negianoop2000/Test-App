package com.example.newapp
import io.flutter.embedding.android.FlutterFragmentActivity
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
import android.widget.Toast
import android.view.ViewGroup
import android.widget.Button

class MainActivity : FlutterFragmentActivity() {
    private val MESSAGE_CHANNEL = "message" // Replace with your actual message channel name
    private val FLASHLIGHT_CHANNEL = "flashlight" // Replace with your actual flashlight channel name

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up the "showMessage" method channel to handle communication from Flutter
        val messageChannelMessenger: BinaryMessenger = flutterEngine.dartExecutor
        MethodChannel(messageChannelMessenger, MESSAGE_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "showMessage") {
                val message = call.arguments.toString()
                Toast.makeText(this@MainActivity, message, Toast.LENGTH_SHORT).show()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }

        // Set up the "turnOnFlashlight" method channel for controlling the flashlight
        val flashlightChannelMessenger: BinaryMessenger = flutterEngine.dartExecutor
        MethodChannel(flashlightChannelMessenger, FLASHLIGHT_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "turnOnFlashlight") {
                try {
                    val cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
                    val cameraId = cameraManager.cameraIdList[0]
                    cameraManager.setTorchMode(cameraId, true)
                    Handler(Looper.getMainLooper()).postDelayed({
                        cameraManager.setTorchMode(cameraId, false)
                    }, 2000)  // Turn off the flashlight after 2 seconds
                    result.success(true)
                } catch (e: CameraAccessException) {
                    result.error("CAMERA_ERROR", "Could not access camera", null)
                }
            } else {
                result.notImplemented()
            }
        }

        // Add the "Test Crash" button to the layout
        val crashButton = Button(this)
        crashButton.text = "Test Crash"
        crashButton.setOnClickListener {
            throw RuntimeException("Test Crash") // Force a crash
        }

        val layoutParams = ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.WRAP_CONTENT
        )

        // Add the button to the view
        addContentView(crashButton, layoutParams)
    }
}
