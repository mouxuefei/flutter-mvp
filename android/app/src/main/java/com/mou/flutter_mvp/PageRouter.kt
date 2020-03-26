package com.mou.flutter_mvp

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.idlefish.flutterboost.containers.BoostFlutterActivity.*


object PageRouter {
    val pageName: Map<String, String> = object : HashMap<String, String>() {
        init {
            put("first", "first")
            put("second", "second")
            put("tab", "tab")
            put("sample://flutterPage", "flutterPage")
        }
    }
    const val NATIVE_PAGE_URL = "sample://nativePage"
    const val FLUTTER_PAGE_URL = "sample://flutterPage"
    const val FLUTTER_FRAGMENT_PAGE_URL = "sample://flutterFragmentPage"

    @JvmOverloads
    fun openPageByUrl(context: Context, url: String, params: MutableMap<String, *>, requestCode: Int = 0): Boolean {
        val path = url.split("\\?").toTypedArray()[0]
        Log.i("openPageByUrl", path)
        return try {
            when {
                pageName.containsKey(path) -> {
                    val intent: Intent = withNewEngine().url(pageName[path] ?: error("")).params(params)
                            .backgroundMode(BackgroundMode.opaque).build(context)
                    if (context is Activity) {
                        val activity: Activity = context as Activity
                        activity.startActivityForResult(intent, requestCode)
                    } else {
                        context.startActivity(intent)
                    }
                    return true
                }
                url.startsWith(FLUTTER_FRAGMENT_PAGE_URL) -> {
                    context.startActivity(Intent(context, FlutterFragmentPageActivity::class.java))
                    return true
                }
                url.startsWith(NATIVE_PAGE_URL) -> {
                    context.startActivity(Intent(context, NativePageActivity::class.java))
                    return true
                }
                else -> false
            }
        } catch (t: Throwable) {
            false
        }
    }
}