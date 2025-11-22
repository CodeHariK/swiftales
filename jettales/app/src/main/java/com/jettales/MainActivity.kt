package com.jettales

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.jettales.ui.theme.JettalesTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // setContent { JettalesTheme { AppBarExamples(navigateBack = { finish() }) } }
        setContent { JettalesTheme { ScaffoldExample() } }
    }
}
