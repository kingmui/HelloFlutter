import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({
    Key? key,
    this.tag,
    required this.child,
  }) : super(key: key);

  final Widget child;
  // 指定日志 tag
  final T? tag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert 在编译 release 版本时会被去除
      assert(() {
        if (kDebugMode) {
          print('${tag ?? key ?? child}: $constraints');
        }
        return true;
      }());
      return child;
    });
  }
}
