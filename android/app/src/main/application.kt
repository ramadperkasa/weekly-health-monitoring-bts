package id.bts.whm

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

import android.app.NotificationManager;
import android.content.Context;


class Application : FlutterApplication(), PluginRegistrantCallback {
    
    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    @Override
    protected void onResume() {
        super.onResume();

        // Removing All Notifications
        closeAllNotifications();
    }

    private void closeAllNotifications() {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }

    override fun registerWith(registry: PluginRegistry?) {
        io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin.registerWith(
                registry?.registrarFor(
                        "io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
    }
}