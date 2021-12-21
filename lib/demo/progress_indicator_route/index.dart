import 'package:flutter/material.dart';

/// Material 组件库中提供了两种进度指示器，LinearProgressIndicator 和 CircularProgressIndicator
/// 它们都可以同时用于精确的进度指示和模糊的进度指示
/// 精确进度通常用于任务进度可以计算和预估的情况，比如文件下载
/// 而模糊进度则用户任务进度无法准确获得的情况，如下拉刷新，数据提交等
///
/// LinearProgressIndicator 是一个线性、条状的进度条
/// CircularProgressIndicator 是一个圆形进度条

class ProgressIndicatorRoute extends StatefulWidget {
  const ProgressIndicatorRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/progress_indicator_route';

  @override
  _ProgressIndicatorRouteState createState() => _ProgressIndicatorRouteState();
}

class _ProgressIndicatorRouteState extends State<ProgressIndicatorRoute>
    with SingleTickerProviderStateMixin {
  final TextStyle _textStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.red,
  );

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // 动画执行时间5秒
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('进度指示器'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '进度色动画',
                style: _textStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: ColorTween(
                    begin: Colors.green,
                    end: Colors.red,
                  ).animate(_animationController),
                  value: _animationController.value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text(
                  'LinearProgressIndicator',
                  style: _textStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text('模糊的进度指示(会执行一个动画)'),
              ),
              LinearProgressIndicator(
                // 指示器的背景色
                backgroundColor: Colors.grey[200],
                // 指示器的进度条颜色
                // 允许我们对进度条的颜色指定动画
                // 如果我们不需要对进度条颜色执行动画（固定颜色），可以通过 AlwaysStoppedAnimation 来指定
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text('精确的进度指示'),
              ),
              // 进度条显示50%
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                // value 表示当前的进度，取值范围为 [0,1]
                // 如果 value 为 null 时则指示器会执行一个循环动画（模糊进度）
                // 当 value 不为 null 时，指示器为一个具体进度的进度条
                value: .5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text(
                  'CircularProgressIndicator',
                  style: _textStyle,
                ),
              ),
              // 模糊进度条(会执行一个旋转动画)
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
              const SizedBox(
                height: 20,
              ),
              // 进度条显示50%，会显示一个半圆
              CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                value: .5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text(
                  '自定义尺寸',
                  style: _textStyle,
                ),
              ),
              // LinearProgressIndicator 和 CircularProgressIndicator 都是取父容器的尺寸作为绘制的边界的
              // 线性进度条高度指定为20
              SizedBox(
                height: 20,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.pinkAccent),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // 圆形进度条直径指定为100
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text(
                  '宽高不等',
                  style: _textStyle,
                ),
              ),
              // 如果 CircularProgressIndicator 显示空间的宽高不同，则会显示为椭圆
              SizedBox(
                height: 100,
                width: 130,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
