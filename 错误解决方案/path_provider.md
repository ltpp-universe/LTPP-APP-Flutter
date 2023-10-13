<!--
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-09 19:36:59
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-06-18 15:55:24
 * @FilePath: \study_bug\错误解决方案\path_provider.md
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
-->
### Execution failed for task ‘:path_provider:verifyReleaseResources’.
看到了 path_provider ，应该是 path_provider 的问题。解决办法就是修改 path_provider 的 build.gradle 中的 compileSdkVersion 版本为 28，就可以成功了。
该文件的目录是在 flutter 的安装目录 C:\Users\14915\AppData\Local\Pub\Cache\hosted\pub.flutter-io.cn\path_provider-0.4.1\android\build.gradle

### Flutter 卡在 Running Gradle task ‘assembleDebug‘... 的解决方法
> flutter项目的android目录中，项目的build.gradle
```dart
    maven { url 'https://maven.aliyun.com/repository/google' }
    maven { url 'https://maven.aliyun.com/repository/jcenter' }
    maven { url 'https://maven.aliyun.com/nexus/content/groups/public'}
    google()
    mavenCentral()
```

> flutter的sdk中进行设置，处于此目录下C:\fluttersdk\packages\flutter_tools\gradle\flutter.gradle
```dart
buildscript {
    repositories {
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'https://maven.aliyun.com/nexus/content/groups/public' }
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.4.0'
    }
}
```

> flutter的sdk中进行设置，处于此目录下，C:\fluttersdk\packages\flutter_tools\gradle\resolve_dependencies.gradle
```dart
repositories {
    maven { url 'https://maven.aliyun.com/repository/google' }
    maven { url 'https://maven.aliyun.com/repository/jcenter' }
    maven { url 'https://maven.aliyun.com/nexus/content/groups/public' }
    maven {
        url "https://storage.flutter-io.cn/download.flutter.io"
    }
}
```

### A network error occurred while checking “https://maven.google.com/”: 信号灯超时时间已到
1、找到flutter sdk的文件目录，打开flutter\packages\flutter_tools\lib\src\http_host_validator.dart
2、将https://maven.google.com/ 修改为https://dl.google.com/dl/android/maven2/
3、关闭cmd命令窗口，重新打开cmd窗口
4、先将原cache文件备份到任意文件夹下。去到flutter\bin目录，删除cache文件夹
5、在cmd命令窗口重新运行flutter doctor,问题解决。
