# WidgetsBindingObserver 监测页面生命周期

```dart
import 'package:flutter/material.dart';

class FlutterLifeCycle extends StatefulWidget {
  @override
  _FlutterLifeCycleState createState() => _FlutterLifeCycleState();
}

class _FlutterLifeCycleState extends State<FlutterLifeCycle> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    /// 添加观察者
    WidgetsBinding.instance.addObserver(this);
  }

  /// 生命周期变化时回调
  //  resumed: 应用可见并可响应用户操作
  //  inactive: 用户可见，但不可响应用户操作
  //  paused: 已经暂停了，用户不可见、不可操作
  //  suspending: 应用被挂起，此状态 IOS 永远不会回调
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('@@@@@@@@@  didChangeAppLifecycleState: $state');
  }

  /// 当前系统改变了一些访问性活动的回调
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
    print('@@@@@@@@@ didChangeAccessibilityFeatures');
  }

  /// 低内存回调
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    print('@@@@@@@@@ didHaveMemoryPressure');
  }

  /// 用户本地设置变化时调用，如系统语言改变
  @override
  void didChangeLocales(List<Locale> locale) {
    super.didChangeLocales(locale);
    print('@@@@@@@@@ didChangeLocales');
  }

  ///应用尺寸改变时回调，例如旋转
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    Size size = WidgetsBinding.instance.window.physicalSize;
    print('@@@@@@@@@ didChangeMetrics  ：宽：${size.width} 高：${size.height}');
  }

  /// on_platform_brightness_change
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    print('@@@@@@@@@ didChangePlatformBrightness');
  }

  /// 文字系数变化
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    print(
        '@@@@@@@@@ didChangeTextScaleFactor  ：${WidgetsBinding.instance.window.textScaleFactor}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('flutter'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    /// 销毁观察者
    WidgetsBinding.instance.removeObserver(this);
  }
}
```
