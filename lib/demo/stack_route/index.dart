import 'package:flutter/material.dart';

/// 层叠布局和 Web 中的绝对定位、Android 中的 Frame 布局是相似的
/// 子组件可以根据距父容器四个角的位置来确定自身的位置
/// 层叠布局允许子组件按照代码中声明的顺序堆叠起来
/// Flutter 中使用 Stack 和 Positioned 这两个组件来配合实现绝对定位
/// Stack 允许子组件堆叠，而 Positioned 用于根据 Stack 的四个角来确定子组件的位置

class StackRoute extends StatelessWidget {
  const StackRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/stack_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack 和绝对定位'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Stack(
            // 决定如何去对齐没有定位（没有使用 Positioned）或部分定位的子组件
            // 所谓部分定位，在这里特指没有在某一个轴上定位
            // left、right 为横轴，top、bottom 为纵轴，只要包含某个轴上的一个定位属性就算在该轴上有定位
            alignment: Alignment.center,
            // 和 Row、Wrap 的 textDirection 功能一样，都用于确定 alignment 对齐的参考系
            // textDirection 的值为 TextDirection.ltr，则 alignment 的 start 代表左，end 代表右，即从左往右的顺序
            // textDirection 的值为 TextDirection.rtl，则 alignment 的 start 代表右，end 代表左，即从右往左的顺序
            // textDirection: TextDirection.ltr,

            // 用于确定没有定位的子组件如何去适应 Stack 的大小
            // StackFit.loose 表示使用子组件的大小
            // StackFit.expand 表示扩伸到 Stack 的大小
            // 未定位 widget 占满 Stack 整个空间
            fit: StackFit.expand,

            // clipBehavior: Clip.none,
            children: <Widget>[
              // Container(
              //   color: Colors.red,
              //   child: const Text(
              //     'Hello world',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // const Positioned(
              //   left: 18.0,
              //   child: Text('I am Jack'),
              // ),
              // const Positioned(
              //   top: 18.0,
              //   child: Text('Your friend'),
              // ),

              const Positioned(
                left: 18.0,
                child: Text('I am Jack'),
              ),
              // 由于第二个子文本组件没有定位，所以 fit 属性会对它起作用
              // 就会占满 Stack。由于 Stack 子元素是堆叠的，所以第一个子文本组件被第二个遮住了
              Container(
                color: Colors.red,
                child: const Text(
                  'Hello world',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Positioned(
                top: 18.0,
                child: Text('Your friend'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
