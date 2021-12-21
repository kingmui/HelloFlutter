import 'package:flutter/material.dart';

/// 弹性布局允许子组件按照一定比例来分配父容器空间
/// Flutter 中的弹性布局主要通过 Flex 和 Expanded 来配合实现
///
/// Flex 组件可以沿着水平或垂直方向排列子组件
/// Flex 继承自 MultiChildRenderObjectWidget，对应的 RenderObject 为 RenderFlex，RenderFlex 中实现了其布局算法
/// Row 和 Column 都继承自 Flex
///
/// Expanded 只能作为 Flex 的孩子（否则会报错），它可以按比例「扩伸」Flex 子组件所占用的空间
/// 因为 Row 和 Column 继都承自 Flex，所以 Expanded 也可以作为它们的孩子

class FlexRoute extends StatelessWidget {
  const FlexRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/flex_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('弹性布局（Flex）'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Flex 的两个子 widget 按 1:2 来占据水平空间
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    // flex 参数为弹性系数，如果为 0 或 null，则 child 是没有弹性的，即不会被扩伸占用的空间
                    // 如果大于 0，所有的 Expanded 按照其 flex 的比例来分割主轴的全部空闲空间
                    flex: 1,
                    child: Container(
                      height: 30.0,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 30.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 100.0,
                  // Flex 的三个子 widget，在垂直方向按 2:1:1 来占用 100 像素的空间
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 30.0,
                          color: Colors.red,
                        ),
                      ),
                      // 占用指定比例的空间，它只是 Expanded 的一个包装类
                      const Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 30.0,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
