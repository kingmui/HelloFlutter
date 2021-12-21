import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// TextField 用于文本输入
///
/// 获取输入内容有两种方式
/// 1. 定义两个变量，用于保存用户名和密码，然后在 onChange 触发时，各自保存一下输入内容
/// 2. 通过 controller 直接获取
///
/// 监听文本变化的两种方式
/// 1. 设置 onChange 回调
/// 2. 通过 controller 监听（除了能监听文本变化外，它还可以设置默认值、选择文本）

class TextFieldRoute extends StatefulWidget {
  const TextFieldRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/textfield_route';

  @override
  _TextFieldRouteState createState() => _TextFieldRouteState();
}

class _TextFieldRouteState extends State<TextFieldRoute> {
  String _userName = '';
  String _userPassword = '';

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _selectionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 监听输入改变
    _userNameController.addListener(() {
      setState(() {
        _userName = _userNameController.text;
      });
    });

    _userPasswordController.addListener(() {
      setState(() {
        _userPassword = _userPasswordController.text;
      });
    });

    _selectionController.text = 'hello world!';
    _selectionController.selection = TextSelection(
        baseOffset: 2, extentOffset: _selectionController.text.length);
  }

  @override
  void dispose() {
    super.dispose();

    _userNameController.dispose();
    _userPasswordController.dispose();
    _selectionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('输入框及表单'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              // 编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件
              // 大多数情况下我们都需要显式提供一个 controller 来与文本框交互
              // 如果没有提供 controller，那么 TextField 内部会自动创建一个
              controller: _userNameController,
              // 是否自动获取焦点
              autofocus: true,
              // 用于控制 TextField 的外观显示，如提示文本、背景颜色、边框等
              decoration: const InputDecoration(
                labelText: '用户名',
                hintText: '用户名或邮箱',
                prefixIcon: Icon(Icons.person),
              ),
              // 用于设置该输入框默认的键盘输入类型
              keyboardType: TextInputType.text,
              // 键盘动作按钮图标(即回车键位图标)
              textInputAction: TextInputAction.done,
              // 正在编辑的文本样式
              style: const TextStyle(
                color: Colors.pink,
              ),
              // 输入框内编辑文本在水平方向的对齐方式
              textAlign: TextAlign.end,
              // 输入框的最大行数，默认为 1。如果为 null，则无行数限制。
              maxLines: 1,
              // 输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数
              maxLength: 10,
              // 决定当输入文本长度超过 maxLength 时如何处理，如截断、超出等
              // maxLengthEnforcement
              // 长按或鼠标右击时出现的菜单，包括 copy、cut、paste 以及 selectAll
              toolbarOptions: const ToolbarOptions(
                copy: true,
                cut: true,
                paste: true,
                selectAll: true,
              ),
              // 输入框内容改变时的回调函数。也可以通过 controller 来监听
              // onChanged: (value) {
              //   setState(() {
              //     _userName = value;
              //   });
              // },
              // 以下两个回调都是在输入框输入完成时触发，比如按了键盘的完成键或搜索键
              // 不同的是两个回调签名不同
              // onEditingComplete 不接收参数
              onEditingComplete: () {
                if (kDebugMode) {
                  print('------------------------------------------>onEditingComplete:');
                }
              },
              // onSubmitted 回调是 ValueChanged<String> 类型，它接收当前输入内容做为参数
              onSubmitted: (value) {
                if (kDebugMode) {
                  print('------------------------------------------>onSubmitted: $value');
                }
              },
              // 用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验
              // inputFormatters: [],
              // 如果为 false，输入框会被禁用，禁用状态不接收输入和事件，同时显示禁用态样式
              enabled: true,
              // 以下这三个属性是用于自定义输入框光标宽度、圆角和颜色的
              cursorWidth: 2.0,
              cursorRadius: const Radius.circular(2.0),
              cursorColor: Colors.blue,
            ),
            TextField(
              controller: _userPasswordController,
              decoration: const InputDecoration(
                labelText: '密码',
                hintText: '您的登录密码',
                prefixIcon: Icon(Icons.lock),
              ),
              // 是否隐藏正在编辑的文本，用于输入密码的场景
              obscureText: true,
              // onChanged: (value) {
              //   setState(() {
              //     _userPassword = value;
              //   });
              // },
            ),
            Text('用户名: $_userName'),
            Text('密码: $_userPassword'),
            // Text('用户名: ${_userNameController.text}'),
            // Text('密码: ${_userPasswordController.text}'),
            TextField(
              controller: _selectionController,
            ),
          ],
        ),
      ),
    );
  }
}
