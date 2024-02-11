package com.futhinov2.app

import android.Manifest
import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.BitmapFactory
import android.hardware.camera2.CameraManager
import android.media.*
import android.media.audiofx.Visualizer
import android.net.Uri
import android.os.Environment
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import kotlin.concurrent.thread
import kotlin.math.abs
//import com.ryanheise.audioservice.AudioServicePlugin

class MainActivity: FlutterActivity() {

    private val channel = "com.futhinov2.app/kotlin"

        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "deleteFile" -> {
                    val arguments = call.arguments<Map<Any, String?>>()
                    if(arguments!=null) {
                        val pathToDelete: String = arguments["fileToDelete"]!!
                        deleteThis(pathToDelete)
                    }
                    result.success("nice")
                }
                "broadcastFileChange" -> {
                    val arguments = call.arguments<Map<Any, String?>>()
                    if(arguments!=null) {
                        val pathToUpdate: String = arguments["filePath"]!!
                        broadcastFileUpdate(pathToUpdate)
                    }
                    result.success("nice")
                }
                "setRingtone" -> {
                    val arguments = call.arguments<Map<Any, String>>()
                    if(arguments!=null) setRingtone(ringtonePath = arguments["path"]!!)
                    result.success("nice")
                }
                "checkSettingPermission" -> {
                    getSettingsPermission()
                    result.success("nice")
                }
                "externalStorage" -> {
                    result.success(getExternalStorageDirectories())
                }
            }
        }
    }

        private fun deleteThis(path: String) {
        File(path).delete()
        broadcastFileUpdate(path)
    }

    private fun broadcastFileUpdate(path: String) {
        context.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(File(path))))
        println("updated!")
    }

        private fun getSettingsPermission() {
        if (!android.provider.Settings.System.canWrite(context)) {
            val intent = Intent(android.provider.Settings.ACTION_MANAGE_WRITE_SETTINGS)
            intent.data = Uri.parse("package:" + context.packageName)
            context.startActivity(intent)
        }
    }

        private fun getExternalStorageDirectories(): String? {
        val files = getExternalFilesDirs(null)
        for (file in files) {
            if (Environment.isExternalStorageRemovable(file)) {
                return file.path.replace("Android/data/com.Phoenix.project/files", "")
            }
        }
        return null
    }
    
        private fun setRingtone(ringtonePath: String) {
        if (android.provider.Settings.System.canWrite(context)) {
            try {
                RingtoneManager.setActualDefaultRingtoneUri(
                        context,
                        RingtoneManager.TYPE_RINGTONE,
                        Uri.fromFile(File(ringtonePath))
                )
            } catch (e: Exception) {
                Log.i("ringtone", e.toString())
                Toast.makeText(context, "Failed setting ringtone!", Toast.LENGTH_SHORT).show()
            }
        } else {
            getSettingsPermission()
        }
    }
}
