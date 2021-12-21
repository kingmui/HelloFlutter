import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Text 用于显示简单样式文本，它包含一些控制文本显示样式的一些属性
/// TextStyle 用于指定文本显示的样式。如颜色、字体、粗细、背景等
/// Text 的所有文本内容只能指定同一种样式，如果需要对一个 Text 内容的不同部分按照不同的样式显示，这时就可以使用 TextSpan，它代表文本的一个「片段」

class TextRoute extends StatefulWidget {
  const TextRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/text_route';

  @override
  _TextRouteState createState() => _TextRouteState();
}

class _TextRouteState extends State<TextRoute> {
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();

    _tapRecognizer = TapGestureRecognizer()..onTap = _handlePress;
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _handlePress() {
    HapticFeedback.vibrate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文本及样式'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '左对齐',
              // 对齐的参考系是Text widget 本身
              textAlign: TextAlign.left,
            ),
            Text(
              '文本居中对齐' * 4,
              textAlign: TextAlign.center,
            ),
            Text(
              '最多显示一行，超出部分省略。' * 2,
              // 指定文本显示的最大行数，默认情况下，文本是自动折行的
              maxLines: 1,
              // 如果有多余的文本，可以通过 overflow 来指定截断方式
              overflow: TextOverflow.ellipsis,
            ),
            const Text(
              '字体缩放',
              // 代表文本相对于当前字体大小的缩放因子
              // 主要是用于系统字体大小设置改变时对 Flutter 应用字体进行全局调整
              // 而 fontSize 通常用于单个文本，字体大小不会跟随系统字体大小变化
              // 该属性的默认值可以通过 MediaQueryData.textScaleFactor 获得
              textScaleFactor: 1.5,
            ),
            Text(
              'Hello world',
              style: TextStyle(
                color: Colors.blue,
                // 可以精确指定字体大小，而 textScaleFactor 只能通过缩放比例来控制
                fontSize: 18.0,
                // 该属性用于指定行高，但它并不是一个绝对值，而是一个因子
                // 具体的行高等于 fontSize * height
                height: 1.2,
                // 由于不同平台默认支持的字体集不同
                // 所以在手动指定字体时一定要先在不同平台测试一下
                fontFamily: 'Courier',
                background: Paint()..color = Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Flutter: '),
                  TextSpan(
                    text: 'https://flutter.dev/',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: _tapRecognizer,
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: 'Flutter: '),
                  TextSpan(
                    text: 'https://flutter.dev/',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: _tapRecognizer,
                  ),
                ],
              ),
            ),
            // 在 Widget 树中，文本的样式默认是可以被继承的
            // 子类文本类组件未指定具体样式时可以使用 Widget 树中父级设置的默认样式
            // 因此，如果在 Widget 树的某一个节点处设置一个默认的文本样式
            // 那么该节点的子树中所有文本都会默认使用这个样式
            // 而 DefaultTextStyle 正是用于设置默认文本样式的
            DefaultTextStyle(
              // 设置文本默认样式
              style: const TextStyle(
                color: Colors.red,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.start,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('Hello world'),
                  Text('Study Flutter'),
                  Text(
                    'Study Flutter',
                    style: TextStyle(
                      // 不继承默认样式
                      inherit: false,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
