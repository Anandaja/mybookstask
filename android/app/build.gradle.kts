plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin last
}

android {
    namespace = "com.example.book_stask_"
    ndkVersion = "29.0.13113456"

    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.book_stask_"
        minSdk = 23 // ✅ Kotlin DSL style
        targetSdk = 34 // Or flutter.targetSdkVersion if defined
        versionCode = 1 // Replace with flutter.versionCode if needed
        versionName = "1.0" // Replace with flutter.versionName if needed
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4") // ✅ Updated version
}
