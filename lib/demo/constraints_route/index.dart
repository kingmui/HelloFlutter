import 'package:flutter/material.dart';

/// 布局类组件都会包含一个或多个子组件，不同的布局类组件对子组件排列（layout）方式不同
///
/// LeafRenderObjectWidget（非容器类组件基类）
/// Widget 树的叶子节点，用于没有子节点的 widget，通常基础组件都属于这一类，如 Image
///
/// SingleChildRenderObjectWidget（单子组件基类）
/// 包含一个子 Widget，如：ConstrainedBox、DecoratedBox 等
///
/// MultiChildRenderObjectWidget（多子组件基类）
/// 包含多个子 Widget，一般都有一个 children 参数，接受一个 Widget 数组。如 Row、Column、Stack 等
///
/// 布局类组件就是指直接或间接继承自 SingleChildRenderObjectWidget 和 MultiChildRenderObjectWidget 的 Widget
/// 它们一般都会有一个 child 或 children 属性用于接收子 Widget
/// 我们看一下继承关系 Widget > RenderObjectWidget > (Leaf/SingleChild/MultiChild)RenderObjectWidget
///
/// 尺寸限制类容器用于限制容器大小，Flutter 中提供了多种这样的容器
/// 如 ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio 等
///
/// Flutter 中有两种布局模型
/// 基于 RenderBox 的盒模型布局
/// 基于 Sliver (RenderSliver) 按需加载列表布局
///
/// 两种布局方式在细节上略有差异，但大体流程相同，布局流程如下：
/// 1. 上层组件向下层组件传递约束（constraints）条件
/// 2. 下层组件确定自己的大小，然后告诉上层组件。注意下层组件的大小必须符合父组件的约束
/// 3. 上层组件确定下层组件相对于自身的偏移和确定自身的大小（大多数情况下会根据子组件的大小来确定自身的大小）
///
/// 盒模型布局组件有两个特点：
/// 1. 组件对应的渲染对象都继承自 RenderBox 类
/// 当我们提到某个组件是 RenderBox，则指它是基于盒模型布局的，而不是说组件是 RenderBox 类的实例
/// 2. 在布局过程中父级传递给子级的约束信息由 BoxConstraints 描述

class ConstraintsRoute extends StatelessWidget {
  const ConstraintsRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/constraints_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('布局原理与约束'),
        actions: const <Widget>[
          // 当我们发现已经使用 SizedBox 或 ConstrainedBox 给子元素指定了固定宽高
          // 但是仍然没有效果时，几乎可以断定：已经有父组件指定了约束
          // 我们会发现右侧 loading 按钮大小并没有发生变化！
          // 这正是因为 AppBar 中已经指定了 actions 按钮的约束条件
          // SizedBox(
          //   width: 20,
          //   height: 20,
          //   child: CircularProgressIndicator(
          //     strokeWidth: 3,
          //     valueColor: AlwaysStoppedAnimation(Colors.white70),
          //   ),
          // ),
          // 所以我们要自定义 loading 按钮大小，就必须通过 UnconstrainedBox 来 “去除” 父元素的限制
          // 实际上将 UnconstrainedBox 换成 Center 或者 Align 也是可以的
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ConstrainedBox 用于对子组件添加额外的约束
              ConstrainedBox(
                // BoxConstraints 是盒模型布局过程中父渲染对象传递给子渲染对象的约束信息
                // 包含最大宽高信息，子组件大小需要在约束的范围内
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                  minHeight: 50.0,
                ),
                // SizedBox 用于给子元素指定固定的宽高
                child: const SizedBox(
                  // 未生效，因为约束的最小高度限制生效
                  height: 5.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                ),
              ),
              // ConstrainedBox 和 SizedBox 都是通过 RenderConstrainedBox 来渲染的
              const SizedBox(
                width: 80.0,
                height: 80.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ),
              // SizedBox 只是 ConstrainedBox 的一个定制
              // 上述代码等价于
              ConstrainedBox(
                // BoxConstraints 还定义了一些便捷的构造函数，用于快速生成特定限制规则的 BoxConstraints
                // BoxConstraints.tight(Size size)，它可以生成固定宽高的限制
                // BoxConstraints.expand() 可以生成一个尽可能大的用以填充另一个容器的 BoxConstraints
                constraints: const BoxConstraints.tightFor(
                  width: 80.0,
                  height: 80.0,
                ),
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.yellow),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text('多重限制'),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 60.0,
                  // 生效
                  minHeight: 60.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    // 生效
                    minWidth: 90.0,
                    minHeight: 20.0,
                  ),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  // 生效
                  minWidth: 90.0,
                  minHeight: 20.0,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 60.0,
                    // 生效
                    minHeight: 60.0,
                  ),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.pink),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Text('UnconstrainedBox'),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 60.0,
                  minHeight: 100.0,
                ),
                // 父 ConstrainedBox 作用于 UnconstrainedBox 上
                // 任何时候子组件都必须遵守其父组件的约束
                child: UnconstrainedBox(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 90.0,
                      minHeight: 20.0,
                    ),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
              // UnconstrainedBox 虽然在其子组件布局时可以取消约束（子组件可以为无限大）
              // 但是 UnconstrainedBox 自身是受其父组件约束的
              // 所以当 UnconstrainedBox 随着其子组件变大后
              // 如果 UnconstrainedBox 的大小超过它父组件约束时，也会导致溢出报错
              UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text('xx' * 30),
                    ],
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
