import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/layout_log_print/index.dart';

/// 通过 LayoutBuilder，我们可以在布局过程中拿到父组件传递的约束信息
/// 然后我们可以根据约束信息动态的构建不同的布局
/// 比如我们实现一个响应式的 Column 组件 ResponsiveColumn，它的功能是当当前可用的宽度小于 200 时，将子组件显示为一列，否则显示为两列
/// 使用场景：
/// 1. 可以使用 LayoutBuilder 来根据设备的尺寸来实现响应式布局
///
/// 2. LayoutBuilder 可以帮我们高效排查问题。
/// 比如我们在遇到布局问题或者想调试组件树中某一个节点布局的约束时 LayoutBuilder 就很有用
///
/// Flutter 是响应式 UI 框架，和命令式 UI 框架最大的不同是
/// 大多数情况下开发者只需要关注数据的变化，数据变化后框架会自动重新构建 UI 而不需要开发者手动去操作每一个组件
/// 所以我们会发现 Widget 会被定义为不可变的（immutable），并且没有提供任何操作组件的 API
/// 因此如果我们想在 Flutter 中获取某个组件的大小和位置就会很困难
/// 当然大多数情况下不会有这个需求，但总有一些场景会需要，而在命令式 UI 框架中是不会存在这个问题的

class LayoutRoute extends StatelessWidget {
  LayoutRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/layout_route';

  final _children = List.filled(6, const Text('A'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LayoutBuilder'),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 190,
            child: ResponsiveColumn(children: _children),
          ),
          ResponsiveColumn(children: _children),
          const LayoutLogPrint(
            child: Text('xx'),
          ),
          // 只有当布局完成时，每个组件的大小和位置才能确定
          Builder(
            builder: (context) {
              return GestureDetector(
                child: const Text('Hello world'),
                onTap: () {
                  if (kDebugMode) {
                    // context.size 可以获取当前上下文 RenderObject 的大小
                    // 对于 Builder、StatelessWidget 以及 StatefulWidget 这样没有对应 RenderObject 的组件（这些组件只是用于组合和代理组件，本身并没有布局和绘制逻辑），获取的是子代中第一个拥有 RenderObject 组件的 RenderObject 对象
                    print(context.size);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // 通过 LayoutBuilder 拿到父组件传递的约束，然后判断 maxWidth 是否小于200
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 200) {
          // 最大宽度小于 200，显示单列
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          );
        } else {
          // 大于 200，显示双列
          var _children = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              _children.add(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  children[i],
                  children[i + 1],
                ],
              ));
            } else {
              _children.add(children[i]);
            }
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: _children,
          );
        }
      },
    );
  }
}
