import 'package:flutter/material.dart';

class GetStateObjectWidget extends StatelessWidget {
  const GetStateObjectWidget({Key? key}) : super(key: key);

  static const String baseRoute = '/get_state_object_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子树中获取 State 对象'),
      ),
      body: Center(
        child: Column(
          children: [
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  // 查找父级最近的 Scaffold 对应的 ScaffoldState 对象
                  ScaffoldState _state =
                      context.findAncestorStateOfType<ScaffoldState>()!;
                  _state.openDrawer();
                },
                child: const Text(
                  '打开抽屉菜单1',
                ),
              );
            }),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  // 如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget 中提供一个 of 静态方法来获取其 State 对象
                  // 直接通过 of 静态方法来获取 ScaffoldState
                  ScaffoldState _state = Scaffold.of(context);
                  _state.openDrawer();
                },
                child: const Text(
                  '打开抽屉菜单2',
                ),
              );
            }),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '我是SnackBar',
                      ),
                    ),
                  );
                },
                child: const Text(
                  '显示SnackBar',
                ),
              );
            }),
            TextButton(
              child: const Text('返回首页'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      drawer: const Drawer(),
    );
  }
}
