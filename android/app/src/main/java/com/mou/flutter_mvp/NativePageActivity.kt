package com.mou.flutter_mvp

import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.mou.flutter_mvp.PageRouter.openPageByUrl
import com.mou.flutter_mvp.databinding.NativePageBinding
import java.util.*


class NativePageActivity : AppCompatActivity(), View.OnClickListener {
    private lateinit var binding: NativePageBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = NativePageBinding.inflate(layoutInflater)
        setContentView(binding.root)
        binding.openNative.setOnClickListener(this)
        binding.openFlutter.setOnClickListener(this)
        binding.openFlutterFragment.setOnClickListener(this)
    }

    override fun onClick(v: View) {
        val params: HashMap<String, String> = HashMap()
        params["test1"] = "v_test1"
        params["test2"] = "v_test2"
        when {
            v === binding.openNative -> {
                openPageByUrl(this, PageRouter.NATIVE_PAGE_URL, params)
            }
            v === binding.openFlutter -> {
                openPageByUrl(this, PageRouter.FLUTTER_PAGE_URL, params)
            }
            v === binding.openFlutterFragment -> {
                openPageByUrl(this, PageRouter.FLUTTER_FRAGMENT_PAGE_URL, params)
            }
        }
    }
}