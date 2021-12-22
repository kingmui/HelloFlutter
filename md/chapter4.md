# 布局类组件

布局类组件都会包含一个或多个子组件，不同的布局类组件对子组件排列（layout）方式不同

- LeafRenderObjectWidget <!-- .element: class="fragment" data-fragment-index="1" -->
- SingleChildRenderObjectWidget <!-- .element: class="fragment" data-fragment-index="2" -->
- MultiChildRenderObjectWidget <!-- .element: class="fragment" data-fragment-index="3" -->

Note: 布局类组件都会包含一个或多个子组件，不同的布局类组件对子组件排列方式不同。布局类组件就是指直接或间接继承自 SingleChildRenderObjectWidget 和 MultiChildRenderObjectWidget 的 Widget，它们一般都会有一个 child 或 children 属性用于接收子 Widget。继承关系 Widget > RenderObjectWidget > (Leaf/SingleChild/MultiChild)RenderObjectWidget



## 布局原理与约束

尺寸限制类容器用于限制容器大小，如 ConstrainedBox、SizedBox、UnconstrainedBox、AspectRatio 等


## 两种布局模型

- 基于 RenderBox 的盒模型布局
- 基于 Sliver (RenderSliver) 按需加载列表布局


## 布局流程

任何时候子组件都必须先遵守父组件的约束

- 上层组件向下层组件传递 constraints 条件
- 下层组件确定自己的大小，然后告诉上层组件。注意下层组件的大小必须符合父组件的约束
- 上层组件确定下层组件相对于自身的偏移和确定自身的大小（大多数情况下会根据子组件的大小来确定自身的大小）


## 盒模型布局组件特点

- 组件对应的渲染对象都继承自 RenderBox 类
- 在布局过程中父级传递给子级的约束信息由 BoxConstraints 描述


## BoxConstraints

盒模型布局过程中父渲染对象传递给子渲染对象的约束信息

```dart
const BoxConstraints({
  this.minWidth = 0.0,
  this.maxWidth = double.infinity,
  this.minHeight = 0.0,
  this.maxHeight = double.infinity,
});

// 生成固定宽高的限制
BoxConstraints.tight(Size size);
// 生成一个尽可能大的用以填充另一个容器的 BoxConstraints
BoxConstraints.expand();
```


## ConstrainedBox

用于对子组件添加额外的约束

```dart
ConstrainedBox(
  constraints: const BoxConstraints(
    minWidth: double.infinity,
    minHeight: 50.0,
  ),
  child: const SizedBox(
    // 未生效，因为约束的最小高度限制生效
    height: 5.0,
    child: DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    ),
  ),
);
```


## SizedBox

用于给子元素指定固定的宽高

```dart
const SizedBox(
  width: 80.0,
  height: 80.0,
  child: DecoratedBox(
    decoration: BoxDecoration(color: Colors.blue),
  ),
);
```

Note: ConstrainedBox 和 SizedBox 都是通过 RenderConstrainedBox 来渲染的


## 多重限制

如果某一个组件有多个父级 `ConstrainedBox` 限制，那么最终会是哪个生效？

```dart [2-5,7-10]
ConstrainedBox(
  constraints: const BoxConstraints(
    minWidth: 60.0,
    minHeight: 60.0,
  ),
  child: ConstrainedBox(
    constraints: const BoxConstraints(
      minWidth: 90.0,
      minHeight: 20.0,
    ),
    child: const DecoratedBox(
      decoration: BoxDecoration(color: Colors.green),
    ),
  ),
);
```


## UnconstrainedBox

子组件不会受到约束，大小完全取决于自己

有什么方法可以彻底去除父 ConstrainedBox 的限制吗？

**任何时候子组件都必须遵守其父组件的约束**

Note: UnconstrainedBox 虽然在其子组件布局时可以取消约束（子组件可以为无限大），但是 UnconstrainedBox 自身是受其父组件约束的，所以当 UnconstrainedBox 随着其子组件变大后，如果 UnconstrainedBox 的大小超过它父组件约束时，也会导致溢出报错



## 线性布局

沿水平或垂直方向排列子组件

Note: 通过 Row 和 Column 来实现线性布局


## 主轴和纵轴

- 如果布局是沿水平方向，那么主轴就是水平方向，而纵轴即垂直方向
- 如果布局是沿垂直方向，那么主轴就是垂直方向，而纵轴即水平方向

Note: 在线性布局中，有两个定义对齐方式的枚举类 MainAxisAlignment 和 CrossAxisAlignment，分别代表主轴对齐和纵轴对齐


## Row

沿水平方向排列其子组件

```dart
Row({
  // 水平方向子组件的布局顺序(是从左往右还是从右往左)，默认为系统语言环境的文本方向
  TextDirection textDirection,
  // 在主轴方向占用的空间，默认是 MainAxisSize.max，表示尽可能多的占用水平方向的空间，此时无论子 widgets 实际占用多少水平空间，Row 的宽度始终等于水平方向的最大宽度；而 MainAxisSize.min 表示尽可能少的占用水平空间，当子组件没有占满水平剩余空间，则 Row 的实际宽度等于所有子组件占用的的水平空间
  MainAxisSize mainAxisSize = MainAxisSize.max,
  // 表示子组件在 Row 所占用的水平空间内对齐方式。如果 mainAxisSize 值为 MainAxisSize.min，则此属性无意义
  // textDirection 是 mainAxisAlignment 的参考系
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  // 表示纵轴（垂直）的对齐方向，默认是 VerticalDirection.down，表示从上到下。
  VerticalDirection verticalDirection = VerticalDirection.down,
  // 表示子组件在纵轴方向的对齐方式，Row 的高度等于子组件中最高的子元素高度
  // verticalDirection 是 crossAxisAlignment 的参考系
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  List<Widget> children = const <Widget>[],
});
```


## Column

在垂直方向排列其子组件

Note: Row 和 Column 都只会在主轴方向占用尽可能大的空间，而纵轴的长度则取决于他们最大子元素的长度


## 嵌套

如果 Row 里面嵌套 Row，或者 Column 里面再嵌套 Column，那么只有最外面的 Row 或 Column 会占用尽可能大的空间，里面 Row 或 Column 所占用的空间为实际大小



## 弹性布局

允许子组件按照一定比例来分配父容器空间

Note: Flutter 中的弹性布局主要通过 Flex 和 Expanded 来配合实现


## Flex

可以沿着水平或垂直方向排列子组件，**Row 和 Column 都继承自 Flex**，参数基本相同。

```dart
Flex({
  // 弹性布局的方向， Row 默认为水平方向，Column 默认为垂直方向
  required this.direction, 
  List<Widget> children = const <Widget>[],
});
```

Note: Flex 本身功能是很强大的，它也可以和 Expanded 组件配合实现弹性布局。Flex 继承自 MultiChildRenderObjectWidget，对应的 RenderObject 为 RenderFlex，RenderFlex 中实现了其布局算法


## Expanded

只能作为 Flex 的孩子（否则会报错），它可以按比例**扩伸** Flex 子组件所占用的空间

```dart
const Expanded({
  // flex 参数为弹性系数，如果为 0 或 null，则 child 是没有弹性的，即不会被扩伸占用的空间
  // 如果大于 0，所有的 Expanded 按照 flex 的比例来分割主轴的全部剩余空间
  int flex = 1, 
  required Widget child,
});
```



## 流式布局

超出屏幕显示范围会自动折行的布局

Note: Flutter 中通过 Wrap 和 Flow 来支持流式布局


## Wrap

```dart
Wrap({
  this.direction = Axis.horizontal,
  this.alignment = WrapAlignment.start,
  // 主轴方向子 widget 的间距
  this.spacing = 0.0,
  // 纵轴方向的对齐方式
  this.runAlignment = WrapAlignment.start,
  // 纵轴方向的间距
  this.runSpacing = 0.0,
  this.crossAxisAlignment = WrapCrossAlignment.start,
  this.textDirection,
  this.verticalDirection = VerticalDirection.down,
  List<Widget> children = const <Widget>[],
});
```


## Flow

主要用于一些需要自定义布局策略或性能要求较高的场景（如动画）


## Flow 优点

- 性能好
- 灵活

Note: Flow 是一个对子组件尺寸以及位置调整非常高效的控件，Flow 用转换矩阵在对子组件进行位置调整的时候进行了优化：在 Flow 定位过后，如果子组件的尺寸或者位置发生了变化，在 FlowDelegate 中的 paintChildren() 方法中调用 context.paintChild 进行重绘，而 context.paintChild 在重绘时使用了转换矩阵，并没有实际调整组件位置。由于我们需要自己实现 FlowDelegate 的 paintChildren() 方法，所以我们需要自己计算每一个组件的位置，因此，可以自定义布局策略


## Flow 缺点

- 使用复杂
- 不能自适应子组件大小，必须通过指定父容器大小或实现 TestFlowDelegate 的 getSize 返回固定大小



## 层叠布局

和 Web 中的绝对定位（absolute）相似

Note: 子组件可以根据距父容器四个角的位置来确定自身的位置。层叠布局允许子组件按照代码中声明的顺序堆叠起来。Flutter 中使用 Stack 和 Positioned 这两个组件来配合实现绝对定位。Stack 允许子组件堆叠，而 Positioned 用于根据 Stack 的四个角来确定子组件的位置


## Stack、Positioned

```dart
Stack(
  // 决定如何去对齐没有定位（没有使用 Positioned）或部分定位的子组件
  alignment: Alignment.center,
  // 和 Row、Wrap 的 textDirection 功能一样，都用于确定 alignment 对齐的参考系
  textDirection: TextDirection.ltr,

  // 用于确定没有定位的子组件如何去适应 Stack 的大小
  // StackFit.loose 表示使用子组件的大小
  // StackFit.expand 表示扩伸到 Stack 的大小
  // 未定位 widget 占满 Stack 整个空间
  fit: StackFit.expand,

  children: <Widget>[
    const Positioned(
      left: 18.0,
      child: Text('I am Jack'),
    ),
  ],
);
```



## 对齐与相对定位

Note: 通过 Stack 和 Positioned，我们可以指定一个或多个子元素相对于父元素各个边的精确偏移，并且可以重叠。如果我们只想简单的调整一个子元素在父元素中的位置，使用 Align 组件会更简单一些


## Alignment

继承自 AlignmentGeometry，表示矩形内的一个点。**会以矩形的中心点作为坐标原点**，即 Alignment(0.0, 0.0)

```dart [12]
Container(
  color: Colors.yellow,
  child: const Align(
    widthFactor: 2,
    heightFactor: 2,
    // 他有两个属性 x、y，分别表示在水平和垂直方向的偏移
    // x、y 的值从 -1 到 1 分别代表矩形左边到右边的距离和顶部到底边的距离
    // 因此 2 个水平（或垂直）单位则等于矩形的宽（或高）
    // 如 Alignment(-1.0, -1.0) 代表矩形的左侧顶点
    // 而 Alignment(1.0, 1.0) 代表右侧底部终点
    // 而 Alignment(1.0, -1.0) 则正是右侧顶点，即 Alignment.topRight
    alignment: Alignment.topRight,
    child: FlutterLogo(
      size: 60,
    ),
  ),
);
```


## FractionalOffset

FractionalOffset 继承自 Alignment

```dart [8]
Container(
  height: 120.0,
  width: 120.0,
  color: Colors.blue[50],
  child: const Align(
    // 它和 Alignment 唯一的区别就是坐标原点不同
    // FractionalOffset 的坐标原点为矩形的左侧顶点，这和布局系统的一致
    alignment: FractionalOffset(0.2, 0.6),
    child: FlutterLogo(
      size: 60,
    ),
  ),
);
```


## Align 和 Stack

- 定位参考系统不同
- Stack 可以有多个子元素，并且子元素可以堆叠，而 Align 只能有一个子元素，不存在堆叠

Note: Align 和 Stack/Positioned 都可以用于指定子元素相对于父元素的偏移。Stack/Positioned 定位的的参考系可以是父容器矩形的四个顶点；而 Align 则需要先通过 alignment 参数来确定坐标原点，不同的 alignment 会对应不同原点，最终的偏移是需要通过 alignment 的转换公式来计算出。


## Center

```dart
class Center extends Align {
  const Center({ Key? key, double widthFactor, double heightFactor, Widget? child })
    : super(key: key, widthFactor: widthFactor, heightFactor: heightFactor, child: child);
}
```

Note: Center 继承自 Align，它比 Align 只少了一个 alignment 参数；由于 Align 的构造函数中 alignment 值为 Alignment.center，所以，我们可以认为 Center 组件其实是对齐方式确定（Alignment.center）了的 Align



## LayoutBuilder

可以在布局过程中拿到父组件传递的约束信息，然后我们可以根据约束信息动态的构建不同的布局
