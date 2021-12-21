import 'package:flutter/material.dart';

/// 所谓线性布局，即指沿水平或垂直方向排列子组件
/// Flutter 中通过 Row 和 Column 来实现线性布局，类似于 Android 中的 LinearLayout 控件
/// Row 和 Column 都继承自 Flex
///
/// 主轴和纵轴
/// 对于线性布局，有主轴和纵轴之分
/// 如果布局是沿水平方向，那么主轴就是指水平方向，而纵轴即垂直方向
/// 如果布局是沿垂直方向，那么主轴就是指垂直方向，而纵轴即水平方向
/// 在线性布局中，有两个定义对齐方式的枚举类 MainAxisAlignment 和 CrossAxisAlignment，分别代表主轴对齐和纵轴对齐

class RowAndColumnRoute extends StatelessWidget {
  const RowAndColumnRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/row_and_column_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('线性布局'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          // 如果 Row 里面嵌套 Row，或者 Column 里面再嵌套 Column
          // 那么只有最外面的 Row 或 Column 会占用尽可能大的空间，里面 Row 或 Column 所占用的空间为实际大小
          child: Column(
            // 表示子组件在纵轴方向的对齐方式，Row 的高度等于子组件中最高的子元素高度
            // crossAxisAlignment 的参考系是 verticalDirection
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // 表示子组件在 Row 所占用的水平空间内对齐方式
                // 如果 mainAxisSize 值为 MainAxisSize.min，则此属性无意义，因为子组件的宽度等于 Row 的宽度
                // 只有当 mainAxisSize 的值为 MainAxisSize.max 时，此属性才有意义
                // textDirection 是 mainAxisAlignment 的参考系
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(' hello world '),
                  Text(' I am Jack '),
                ],
              ),
              Row(
                // 表示 Row 在主轴(水平)方向占用的空间
                // 默认是 MainAxisSize.max，表示尽可能多的占用水平方向的空间，此时无论子 widgets 实际占用多少水平空间，Row 的宽度始终等于水平方向的最大宽度
                // 而 MainAxisSize.min 表示尽可能少的占用水平空间，当子组件没有占满水平剩余空间，则 Row 的实际宽度等于所有子组件占用的的水平空间
                mainAxisSize: MainAxisSize.min,
                // Row 的宽度等于两个 Text 的宽度和，所以对齐是无意义的
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(' hello world '),
                  Text(' I am Jack '),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // 表示水平方向子组件的布局顺序(是从左往右还是从右往左)
                // 默认为系统当前 Locale 环境的文本方向(如中文、英语都是从左往右，而阿拉伯语是从右往左)
                textDirection: TextDirection.rtl,
                children: const <Widget>[
                  Text(' hello world '),
                  Text(' I am Jack '),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // 表示 Row 纵轴（垂直）的对齐方向，默认是 VerticalDirection.down，表示从上到下
                // 自底向顶排列
                verticalDirection: VerticalDirection.up,
                children: const <Widget>[
                  Text(
                    ' hello world ',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text(' I am Jack '),
                ],
              ),
              Column(
                // 在水平方向对齐是有边界的
                // 总宽度为 Column 占用空间的实际宽度而实际的宽度取决于子项中宽度最大的 Widget
                // Row 和 Column 都只会在主轴方向占用尽可能大的空间，而纵轴的长度则取决于他们最大子元素的长度
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text('hi'),
                  Text('world'),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text('强制更改宽度'),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  // 使宽度占用尽可能多的空间
                  minWidth: double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Text('hi'),
                    Text('world'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
