package com.mou.flutter_mvp

import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.Platform
import com.idlefish.flutterboost.Utils
import com.idlefish.flutterboost.interfaces.INativeRouter
import com.mou.flutter_mvp.PageRouter.openPageByUrl
import io.flutter.app.FlutterApplication
import io.flutter.embedding.android.FlutterView;

/**
 * @FileName: App.java
 * @author: villa_mou
 * @date: 03-09:42
 * @version V1.0 <描述当前版本功能>
 * @desc
 */
class App : FlutterApplication(){
    override fun onCreate() {
        super.onCreate()
        val router: INativeRouter = INativeRouter { context, url, urlParams, requestCode, exts ->
            val assembleUrl: String = Utils.assembleUrl(url, urlParams)
            context?.let { openPageByUrl(it, assembleUrl, urlParams) }
        }

        val boostLifecycleListener: FlutterBoost.BoostLifecycleListener = object : FlutterBoost.BoostLifecycleListener {
            override fun beforeCreateEngine() {}
            override fun onEngineCreated() {}
            override fun onPluginsRegistered() {}
            override fun onEngineDestroy() {}
        }

        //
        // AndroidManifest.xml 中必须要添加 flutterEmbedding 版本设置
        //
        //   <meta-data android:name="flutterEmbedding"
        //               android:value="2">
        //    </meta-data>
        // GeneratedPluginRegistrant 会自动生成 新的插件方式　
        //
        // 插件注册方式请使用
        // FlutterBoost.instance().engineProvider().getPlugins().add(new FlutterPlugin());
        // GeneratedPluginRegistrant.registerWith()，是在engine 创建后马上执行，放射形式调用
        //


        //
        // AndroidManifest.xml 中必须要添加 flutterEmbedding 版本设置
        //
        //   <meta-data android:name="flutterEmbedding"
        //               android:value="2">
        //    </meta-data>
        // GeneratedPluginRegistrant 会自动生成 新的插件方式　
        //
        // 插件注册方式请使用
        // FlutterBoost.instance().engineProvider().getPlugins().add(new FlutterPlugin());
        // GeneratedPluginRegistrant.registerWith()，是在engine 创建后马上执行，放射形式调用
        //
        val platform: Platform = FlutterBoost.ConfigBuilder(this, router)
                .isDebug(true)
                .whenEngineStart(FlutterBoost.ConfigBuilder.ANY_ACTIVITY_CREATED)
                .renderMode(FlutterView.RenderMode.texture)
                .lifecycleListener(boostLifecycleListener)
                .build()
        FlutterBoost.instance().init(platform)
    }
}