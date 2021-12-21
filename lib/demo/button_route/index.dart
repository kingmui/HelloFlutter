import 'package:flutter/material.dart';

/// Material 组件库中提供了多种按钮组件如 ElevatedButton、TextButton、OutlineButton 等
/// 它们都是直接或间接对 RawMaterialButton 组件的包装定制，所以他们大多数属性都和 RawMaterialButton 一样

class ButtonRoute extends StatelessWidget {
  const ButtonRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/button_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 漂浮按钮，默认带有阴影和灰色背景
            // 按下后，阴影会变大
            ElevatedButton(
              child: const Text('ElevatedButton'),
              onPressed: () {},
            ),
            // 文本按钮，默认背景透明并不带阴影
            // 按下后，会有背景色
            TextButton(
              child: const Text('TextButton'),
              onPressed: () {},
            ),
            // 默认有一个边框，不带阴影且背景透明
            // 按下后，边框颜色会变亮、同时出现背景和阴影(较弱)
            OutlinedButton(
              child: const Text('OutlinedButton'),
              onPressed: () {},
            ),
            // IconButton 是一个可点击的 Icon，不包括文字，默认没有背景
            // 点击后会出现背景
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {},
            ),

            // ElevatedButton、TextButton、OutlineButton 都有一个 icon 构造函数
            // 通过它可以轻松创建带图标的按钮
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('发送'),
              onPressed: () {},
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('添加'),
              onPressed: () {},
            ),
            TextButton.icon(
              icon: const Icon(Icons.info),
              label: const Text('详情'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
