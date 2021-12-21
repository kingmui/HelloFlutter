import 'package:flutter/material.dart';

/// 通过 Stack 和 Positioned，我们可以指定一个或多个子元素相对于父元素各个边的精确偏移，并且可以重叠
/// 但如果我们只想简单的调整一个子元素在父元素中的位置的话，使用 Align 组件会更简单一些
///
/// Align 和 Stack/Positioned 都可以用于指定子元素相对于父元素的偏移，但它们还是有两个主要区别：
/// 1. 定位参考系统不同
/// Stack/Positioned 定位的的参考系可以是父容器矩形的四个顶点
/// 而 Align 则需要先通过 alignment 参数来确定坐标原点，不同的 alignment 会对应不同原点
/// 最终的偏移是需要通过 alignment 的转换公式来计算出
///
/// 2. Stack 可以有多个子元素，并且子元素可以堆叠，而 Align 只能有一个子元素，不存在堆叠

class AlignRoute extends StatelessWidget {
  const AlignRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/align_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('对齐与相对定位（Align）'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),

        /// Alignment
        // child: Container(
        //   // height: 120.0,
        //   // width: 120.0,
        //   color: Colors.yellow,
        //   child: const Align(
        //     widthFactor: 2,
        //     heightFactor: 2,
        //     // Alignment 继承自 AlignmentGeometry，表示矩形内的一个点
        //     // 他有两个属性 x、y，分别表示在水平和垂直方向的偏移
        //     // Alignment Widget 会以矩形的中心点作为坐标原点，即 Alignment(0.0, 0.0)
        //     // x、y 的值从 -1 到 1 分别代表矩形左边到右边的距离和顶部到底边的距离
        //     // 因此 2 个水平（或垂直）单位则等于矩形的宽（或高）
        //     // 如 Alignment(-1.0, -1.0) 代表矩形的左侧顶点
        //     // 而 Alignment(1.0, 1.0) 代表右侧底部终点
        //     // 而 Alignment(1.0, -1.0) 则正是右侧顶点，即 Alignment.topRight
        //     // 为了使用方便，矩形的原点、四个顶点，以及四条边的终点在 Alignment 类中都已经定义为了静态常量
        //     // Alignment 可以通过其坐标转换公式将其坐标转为子元素的具体偏移坐标
        //     // (Alignment.x * childWidth / 2 + childWidth / 2, Alignment.y * childHeight / 2 + childHeight / 2)
        //     alignment: Alignment.topRight,
        //     child: FlutterLogo(
        //       size: 60,
        //     ),
        //   ),
        // ),

        /// FractionalOffset
        // child: Container(
        //   height: 120.0,
        //   width: 120.0,
        //   color: Colors.blue[50],
        //   child: const Align(
        //     // FractionalOffset 继承自 Alignment
        //     // 它和 Alignment 唯一的区别就是坐标原点不同
        //     // FractionalOffset 的坐标原点为矩形的左侧顶点，这和布局系统的一致
        //     // FractionalOffset 的坐标转换公式为
        //     // 实际偏移 = (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
        //     alignment: FractionalOffset(0.2, 0.6),
        //     child: FlutterLogo(
        //       size: 60,
        //     ),
        //   ),
        // ),

        /// Center 组件
        child: Column(
          children: const [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              // Center 继承自 Align，它比 Align 只少了一个 alignment 参数
              // 由于 Align 的构造函数中 alignment 值为 Alignment.center
              // 所以，我们可以认为 Center 组件其实是对齐方式确定（Alignment.center）了的 Align
              child: Center(
                // widthFactor 或 heightFactor 为 null 时组件的宽高将会占用尽可能多的空间
                child: Text('Hello world'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: Text('Hello world'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
