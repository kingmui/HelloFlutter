import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/constants/index.dart';
import 'package:hello_flutter/routes/index.dart';
import 'package:hello_flutter/themes/theme.dart';

void collectLog(String line) {
  // 收集日志
}

void reportErrorAndLog(FlutterErrorDetails details) {
  // 上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return FlutterErrorDetails(
    exception: obj,
    stack: stack,
  );
}

void main() {
  // 先将 onError 保存起来
  var onError = FlutterError.onError;

  FlutterError.onError = (details) {
    // 调用默认的 onError
    onError?.call(details);
    // 上报
    reportErrorAndLog(details);

    if (kDebugMode) {
      print(
          '------------------------------------------>FlutterError: $details');
    }
  };

  runZoned(
    () => runApp(const MyApp()),
    zoneSpecification: ZoneSpecification(
      // 拦截 print
      print: (self, parent, zone, line) {
        collectLog(line);
        parent.print(zone, 'Interceptor: $line');
      },
      // 拦截未处理的异步错误
      handleUncaughtError: (self, parent, zone, error, stackTrace) {
        FlutterErrorDetails details = makeDetails(error, stackTrace);
        reportErrorAndLog(details);
        parent.print(zone, '${error.toString()} $stackTrace');
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;

    return MaterialApp(
      // By default on desktop, scrollbars are applied by the
      // ScrollBehavior. This overrides that. All vertical scrollables
      // need to be audited before enabling this feature
      scrollBehavior:
          const MaterialScrollBehavior().copyWith(scrollbars: false),
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // This is the theme of your application.
      theme: MyThemeData.lightThemeData,
      darkTheme: MyThemeData.darkThemeData,
      initialRoute: initialRoute,
      // supportedLocales: const [
      //   Locale.fromSubtags(
      //     languageCode: 'zh',
      //     scriptCode: 'Hans',
      //     countryCode: 'CN',
      //   ),
      //   Locale.fromSubtags(
      //     languageCode: 'en',
      //     countryCode: 'US',
      //   ),
      // ],
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
      // navigatorObservers,
      // onUnknownRoute
    );
  }
}
