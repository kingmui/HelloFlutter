import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Form 继承自 StatefulWidget 对象，它对应的状态类为 FormState
///
/// Form 的子孙元素必须是 FormField 类型
/// 为了方便使用，Flutter 提供了一个 TextFormField 组件，它继承自 FormField 类
/// 也是 TextField 的一个包装类，所以除了 FormField 定义的属性之外，它还包括 TextField 的属性
///
/// FormState 为 Form 的 State 类，可以通过 Form.of() 或 GlobalKey 获得
/// 我们可以通过它来对 Form 的子孙 FormField 进行统一操作
/// 其常用的三个方法
/// 1. FormState.validate()：调用此方法后，会调用 Form 子孙 FormField 的 validate 回调
/// 如果有一个校验失败，则返回 false，所有校验失败项都会返回用户返回的错误提示
/// 2. FormState.save()：调用此方法后，会调用 Form 子孙 FormField 的 save 回调，用于保存表单内容
/// 3. FormState.reset()：调用此方法后，会将子孙 FormField 的内容清空

class FormRoute extends StatefulWidget {
  const FormRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/form_route';

  @override
  _FormRouteState createState() => _FormRouteState();
}

class _FormRouteState extends State<FormRoute> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          // 设置 globalKey，用于后面获取 FormState
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // 决定 Form 所在的路由是否可以直接返回（如点击返回按钮）
          // 该回调返回一个 Future 对象，如果 Future 的最终结果是 false，则当前路由不会返回
          // 如果为 true，则会返回到上一个路由。通常用于拦截返回按钮
          // onWillPop: () {
          //   return Future.value(false);
          // },
          // Form 的任意一个子 FormField 内容发生变化时会触发此回调
          onChanged: () {
            if (kDebugMode) {
              print('------------------------------------------>onChanged:');
            }
          },
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  hintText: '用户名或邮箱',
                  icon: Icon(Icons.person),
                ),
                // 校验用户名
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : '用户名不能为空';
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '密码',
                  hintText: '您的登录密码',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                // 校验密码
                validator: (v) {
                  return v!.trim().length > 5 ? null : '密码不能少于6位';
                },
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('登录 GlobalKey'),
                        ),
                        onPressed: () {
                          // 通过 _formKey.currentState 获取 FormState 后，
                          // 调用 validate() 方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            // 验证通过提交数据
                            if (kDebugMode) {
                              print(
                                  '------------------------------------------>:验证通过提交数据 GlobalKey');
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      // 由于本 widget 也是 Form 的子代 widget，所以可以通过下面方式获取 FormState
                      if (Form.of(context)!.validate()) {
                        //验证通过提交数据
                        if (kDebugMode) {
                          print(
                              '------------------------------------------>:验证通过提交数据 Form.of(context)');
                        }
                      }
                    },
                    child: const Text('登录 Form.of(context)'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
