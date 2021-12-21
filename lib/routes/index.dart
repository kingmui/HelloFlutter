import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/constants/index.dart';
import 'package:hello_flutter/demo/align_route/index.dart';
import 'package:hello_flutter/demo/button_route/index.dart';
import 'package:hello_flutter/demo/constraints_route/index.dart';
import 'package:hello_flutter/demo/flex_route/index.dart';
import 'package:hello_flutter/demo/flow_route/index.dart';
import 'package:hello_flutter/demo/focus_route/index.dart';
import 'package:hello_flutter/demo/form_route/index.dart';
import 'package:hello_flutter/demo/get_state_object_route/index.dart';
import 'package:hello_flutter/demo/image_route/index.dart';
import 'package:hello_flutter/demo/layout_route/index.dart';
import 'package:hello_flutter/demo/progress_indicator_route/index.dart';
import 'package:hello_flutter/demo/row_and_column_route/index.dart';
import 'package:hello_flutter/demo/stack_route/index.dart';
import 'package:hello_flutter/demo/switch_and_checkbox_route/index.dart';
import 'package:hello_flutter/demo/text_route/index.dart';
import 'package:hello_flutter/demo/textfield_route/index.dart';
import 'package:hello_flutter/demo/tip_route/index.dart';
import 'package:hello_flutter/pages/life_cycle/index.dart';
import 'package:hello_flutter/pages/main_screen/index.dart';

part 'config.dart';

class RouteConfiguration {
  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (final path in paths) {
      if (path.baseRoute == settings.name) {
        if (kDebugMode) {
          print(
              '------------------------------------------>Route arguments ${settings.name}: ${settings.arguments}');
        }

        /// 表示占有整个屏幕空间的一个模态路由页面
        /// 它还定义了路由构建及切换时过渡动画的相关接口及属性
        return MaterialPageRoute<void>(
          /// 是一个 WidgetBuilder 类型的回调函数，它的作用是构建路由页面的具体内容
          /// 返回值是一个 widget。我们通常要实现此回调，返回新路由的实例
          builder: (context) => path.builder(
              context, (settings.arguments ?? {}) as Map<dynamic, dynamic>),

          /// 包含路由的配置信息，如路由名称、是否初始路由（首页）
          settings: settings,

          /// 默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中
          /// 如果想在路由没用的时候释放其所占用的所有资源，可以设置 maintainState 为 false
          // maintainState
          /// 表示新的路由页面是否是一个全屏的模态对话框
          /// 在 iOS 中，如果 fullscreenDialog 为 true，新页面将会从屏幕底部滑入（而不是水平方向）
          // fullscreenDialog
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    // return null;

    return MaterialPageRoute<void>(
      builder: (context) => const MainScreenPage(),
      settings: settings,
    );
  }
}
