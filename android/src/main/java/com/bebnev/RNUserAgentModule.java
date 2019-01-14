package com.bebnev;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.content.pm.PackageInfo;
import android.util.Log;
import android.os.Build;
import android.webkit.WebSettings;
import android.webkit.WebView;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class RNUserAgentModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public RNUserAgentModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "RNUserAgent";
    }

    protected String getUserAgent() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            return System.getProperty("http.agent");
        }

        return "";
    }

    protected String getWebViewUserAgent() {
        if (Build.VERSION.SDK_INT >= 17) {
            return WebSettings.getDefaultUserAgent(this.reactContext);
        }

        return new WebView(this.reactContext).getSettings().getUserAgentString();
    }

    @Override
    public Map<String, Object> getConstants() {
        HashMap<String, Object> constants = new HashMap<String, Object>();

        PackageManager packageManager = this.reactContext.getPackageManager();
        String packageName = this.reactContext.getPackageName();
        String shortPackageName = packageName.substring(packageName.lastIndexOf(".") + 1);
        String applicationName = "";
        String applicationVersion = "";
        Integer buildNumber = 0;
        String userAgent = this.getUserAgent();

        try {
            PackageInfo info = packageManager.getPackageInfo(packageName, 0);
            applicationName = this.reactContext.getApplicationInfo().loadLabel(this.reactContext.getPackageManager()).toString();
            applicationVersion = info.versionName;
            buildNumber = info.versionCode;
            userAgent = shortPackageName + '/' + applicationVersion + '.' + buildNumber.toString() + ' ' + userAgent;

        } catch(PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }

        constants.put("systemName", "Android");
        constants.put("systemVersion", Build.VERSION.RELEASE);
        constants.put("packageName", packageName);
        constants.put("shortPackageName", shortPackageName);
        constants.put("applicationName", applicationName);
        constants.put("applicationVersion", applicationVersion);
        constants.put("applicationBuildNumber", buildNumber);
        constants.put("userAgent", userAgent);
        constants.put("webViewUserAgent", this.getWebViewUserAgent());

        return constants;
    }
}