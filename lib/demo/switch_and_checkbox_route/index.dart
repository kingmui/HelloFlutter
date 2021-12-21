import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Material 组件库中提供了 Material 风格的单选开关 Switch 和复选框 Checkbox
/// 虽然它们都是继承自 StatefulWidget，但它们本身不会保存当前选中状态，选中状态都是由父组件来管理的
/// 当 Switch 或 Checkbox 被点击时，会触发它们的 onChanged 回调，我们可以在此回调中处理选中状态改变逻辑

class SwitchAndCheckboxRoute extends StatefulWidget {
  const SwitchAndCheckboxRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/switch_and_checkbox_route';

  @override
  _SwitchAndCheckboxRouteState createState() => _SwitchAndCheckboxRouteState();
}

class _SwitchAndCheckboxRouteState extends State<SwitchAndCheckboxRoute> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('单选开关和复选框'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Switch(
              value: _switchSelected,
              onChanged: (value) {
                setState(() {
                  _switchSelected = value;
                });
              },
            ),
            Checkbox(
              value: _checkboxSelected,
              // 设置激活态的颜色
              activeColor: Colors.red,
              // 是否为三态，默认值为 false ，这时 Checkbox 有两种状态即「选中」和「不选中」
              // 如果 tristate 值为 true 时，value 的值会增加一个状态 null
              // tristate: true,
              onChanged: (value) {
                setState(() {
                  if (kDebugMode) {
                    print('------------------------------------------>Checkbox: $value');
                  }
                  if (value != null) {
                    _checkboxSelected = value;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
