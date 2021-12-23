import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 焦点可以通过 FocusNode 和 FocusScopeNode 来控制
/// 默认情况下，焦点由 FocusScope 来管理，它代表焦点控制范围
/// 可以在这个范围内可以通过 FocusScopeNode 在输入框之间移动焦点、设置默认焦点等
/// 我们可以通过 FocusScope.of(context) 来获取 Widget 树中默认的 FocusScopeNode

class FocusRoute extends StatefulWidget {
  const FocusRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/focus_route';

  @override
  _FocusRouteState createState() => _FocusRouteState();
}

class _FocusRouteState extends State<FocusRoute> {
  // 焦点可以通过 FocusNode 和 FocusScopeNode 来控制
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  FocusScopeNode? focusScopeNode;

  @override
  void initState() {
    super.initState();

    // FocusNode 继承自 ChangeNotifier，通过 FocusNode 可以监听焦点的改变事件
    focusNode3.addListener(() {
      if (kDebugMode) {
        // 获得焦点时 focusNode.hasFocus 值为 true，失去焦点时为 false
        print(
            '------------------------------------------>focusNode3.hasFocus: ${focusNode3.hasFocus}');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('焦点'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('控制焦点'),
              const SizedBox(
                height: 20,
              ),
              TextField(
                autofocus: true,
                // 用于控制 TextField 是否占有当前键盘的输入焦点。它是我们和键盘交互的一个句柄（handle）
                // 默认情况下，焦点由 FocusScope 来管理，它代表焦点控制范围
                // 可以在这个范围内可以通过 FocusScopeNode 在输入框之间移动焦点、设置默认焦点等
                focusNode: focusNode1,
                decoration: const InputDecoration(labelText: 'input1'),
              ),
              TextField(
                focusNode: focusNode2,
                decoration: const InputDecoration(labelText: 'input2'),
              ),
              Builder(
                builder: (ctx) {
                  return Column(
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text('移动焦点'),
                        onPressed: () {
                          // 将焦点从第一个 TextField 移到第二个 TextField

                          // 这是一种写法
                          // FocusScope.of(context).requestFocus(focusNode2);

                          // 这是第二种写法
                          focusScopeNode ??= FocusScope.of(context);
                          focusScopeNode?.requestFocus(focusNode2);
                        },
                      ),
                      ElevatedButton(
                        child: const Text('隐藏键盘'),
                        onPressed: () {
                          // 当所有编辑框都失去焦点时键盘就会收起
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                focusNode: focusNode3,
                decoration: const InputDecoration(
                  labelText: '监听焦点状态改变事件',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: '自定义样式',
                  prefixIcon: Icon(Icons.person),
                  // TextField 在绘制下划线时使用的颜色是主题色里面的 hintColor（提示文本颜色也是用的 hintColor）
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  // 获得焦点下划线设为蓝色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text('复写主题色'),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  // 定义下划线颜色
                  hintColor: Colors.purple,
                  inputDecorationTheme: const InputDecorationTheme(
                    // 定义 label 字体样式
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    // decoration 中可以设置 hintStyle，它可以覆盖 hintColor
                    // 定义提示文本样式
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                child: Column(
                  children: const <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: '用户名',
                        hintText: '用户名或邮箱',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: '密码',
                        hintText: '您的登录密码',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text('自定义下划线宽度'),
              ),
              // 无法直接定义下划线宽度。可以通过隐藏掉 TextField 本身的下划线，然后通过 Container 去嵌套定义样式
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.green,
                      width: 1.0,
                    ),
                  ),
                ),
                child: const TextField(
                  // 用于设置该输入框默认的键盘输入类型
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '邮箱',
                    hintText: '电子邮件地址',
                    prefixIcon: Icon(Icons.email),
                    // 隐藏下划线
                    border: InputBorder.none,
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
