import 'package:flutter/material.dart';

/// 我们把超出屏幕显示范围会自动折行的布局称为流式布局
/// Flutter 中通过 Wrap 和 Flow 来支持流式布局
///
/// Flow 主要用于一些需要自定义布局策略或性能要求较高的场景（如动画中）
/// 优点
/// 性能好。Flow 是一个对子组件尺寸以及位置调整非常高效的控件，Flow 用转换矩阵在对子组件进行位置调整的时候进行了优化：在 Flow 定位过后，如果子组件的尺寸或者位置发生了变化，在 `FlowDelegate` 中的 `paintChildren()` 方法中调用 `context.paintChild` 进行重绘，而 `context.paintChild` 在重绘时使用了转换矩阵，并没有实际调整组件位置
/// 灵活。由于我们需要自己实现 `FlowDelegate` 的 `paintChildren()` 方法，所以我们需要自己计算每一个组件的位置，因此，可以自定义布局策略
///
/// 缺点
/// 使用复杂
/// Flow 不能自适应子组件大小，必须通过指定父容器大小或实现 `TestFlowDelegate` 的 `getSize` 返回固定大小

class FlowRoute extends StatelessWidget {
  const FlowRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/flow_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('流式布局'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  // 右边溢出部分报错
                  // 这是因为 Row 默认只有一行，如果超出屏幕不会折行
                  // 我们把超出屏幕显示范围会自动折行的布局称为流式布局
                  // Flutter中通过 Wrap 和 Flow 来支持流式布局
                  Text('xxx' * 100),
                ],
              ),
              Wrap(
                // 主轴方向子 widget 的间距(水平)
                spacing: 8.0,
                // 纵轴方向的间距（垂直）
                runSpacing: 4.0,
                // 纵轴方向的对齐方式
                // runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.center,
                children: const <Widget>[
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('A'),
                    ),
                    label: Text('Hamilton'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('M'),
                    ),
                    label: Text('Lafayette'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('H'),
                    ),
                    label: Text('Mulligan'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('J'),
                    ),
                    label: Text('Laurens'),
                  ),
                ],
              ),
              Flow(
                delegate: TestFlowDelegate(
                  margin: const EdgeInsets.all(10.0),
                ),
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.red,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.green,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.brown,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.purple,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  // 确定每个子 widget 位置
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    // 计算每一个子 widget 的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        // 绘制子 widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  // 由于 Flow 不能自适应子 widget 的大小，我们通过在 getSize 返回一个固定大小来指定 Flow 的大小
  @override
  Size getSize(BoxConstraints constraints) {
    // 指定 Flow 的大小
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置 Flow 大小
    return const Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
