import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LifeCyclePage extends StatefulWidget {
  const LifeCyclePage({
    Key? key,
    this.initValue = 0,
  }) : super(key: key);

  static const String baseRoute = '/life_cycle';

  final int initValue;

  @override
  _LifeCyclePageState createState() => _LifeCyclePageState();
}

class _LifeCyclePageState extends State<LifeCyclePage> {
  int _counter = 0;

  /// 当 widget 第一次插入到 widget 树时会被调用，对于每一个 State 对象，Flutter 框架只会调用一次该回调
  /// 通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等
  @override
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.initValue;

    if (kDebugMode) {
      print('------------------------------------------>initState');
    }
  }

  /// 会在如下场景被调用
  /// 1. 在调用 initState() 之后
  /// 2. 在调用 didUpdateWidget() 之后
  /// 3. 在调用 setState() 之后
  /// 4. 在调用 didChangeDependencies() 之后
  /// 5. 在 State 对象从树中一个位置移除后（会调用 deactivate），又重新插入到树的其它位置之后
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('------------------------------------------>build');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Cycle'),
      ),
      body: Center(
        child: TextButton(
          child: Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline2,
          ),
          // 点击后计数器自增
          onPressed: () => setState(
            () => ++_counter,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  /// 在 widget 重新构建时，Flutter 框架会调用 widget.canUpdate 来检测 widget 树中同一位置的新旧节点
  /// 然后决定是否需要更新，如果 widget.canUpdate 返回 true 则会调用此回调
  /// widget.canUpdate 会在新旧 widget 的 key 和 runtimeType 同时相等时会返回true
  /// 也就是说在在新旧 widget 的 key 和 runtimeType 同时相等时该回调就会被调用
  @override
  void didUpdateWidget(LifeCyclePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (kDebugMode) {
      print('------------------------------------------>didUpdateWidget');
    }
  }

  /// 当 State 对象从树中被移除时，会调用此回调
  /// 在一些场景下，Flutter 框架会将 State 对象重新插到树中
  /// 如包含此 State 对象的子树在树的一个位置移动到另一个位置时（可以通过 GlobalKey 来实现）
  /// 如果移除后没有重新插入到树中则紧接着会调用 dispose() 方法
  @override
  void deactivate() {
    super.deactivate();
    if (kDebugMode) {
      print('------------------------------------------>deactivate');
    }
  }

  /// 当 State 对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    if (kDebugMode) {
      print('------------------------------------------>dispose');
    }
  }

  /// 此回调是专门为了开发调试而提供的
  /// 在热重载（hot reload）时会被调用
  /// 此回调在 Release 模式下永远不会被调用
  @override
  void reassemble() {
    super.reassemble();
    if (kDebugMode) {
      print('------------------------------------------>reassemble');
    }
  }

  /// 当 State 对象的依赖发生变化时会被调用
  /// 典型的场景是当系统语言 Locale 或应用主题改变时，Flutter 框架会通知 widget 调用此回调
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print('------------------------------------------>didChangeDependencies');
    }
  }
}
