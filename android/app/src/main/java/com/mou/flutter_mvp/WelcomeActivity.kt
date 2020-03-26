package com.mou.flutter_mvp

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.mou.flutter_mvp.databinding.ActivityWelcomeBinding

/**
 * @FileName: WelcomeActivity.java
 * @author: villa_mou
 * @date: 03-14:53
 * @version V1.0 <描述当前版本功能>
 * @desc
 */
class WelcomeActivity :AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding =ActivityWelcomeBinding.inflate(layoutInflater)
        setContentView(binding.root)
        binding.btn.setOnClickListener { startActivity(Intent(this,MainActivity::class.java)) }
    }
}