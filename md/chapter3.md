# 基础组件

- 文本、字体样式 <!-- .element: class="fragment" data-fragment-index="1" -->
- 按钮 <!-- .element: class="fragment" data-fragment-index="2" -->
- 图片和Icon <!-- .element: class="fragment" data-fragment-index="3" -->
- 单选框和复选框 <!-- .element: class="fragment" data-fragment-index="4" -->
- 输入框和表单 <!-- .element: class="fragment" data-fragment-index="5" -->
- 进度指示器 <!-- .element: class="fragment" data-fragment-index="6" -->



## 文本、字体样式


## Text

Text 用于显示简单样式文本，它包含一些控制文本显示样式的一些属性 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
Text("Hello world",
  textAlign: TextAlign.left,
);

Text("Hello world! I'm Jack. "*4,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
);

Text("Hello world",
  textScaleFactor: 1.5,
);
```
<!-- .element: class="fragment" data-fragment-index="2" -->


## TextStyle

TextStyle 用于指定文本显示的样式。如颜色、字体、粗细、背景等 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart [3-16]
Text(
  'Hello world',
  style: TextStyle(
    color: Colors.blue,
    // 可以精确指定字体大小，而 textScaleFactor 只能通过缩放比例来控制
    fontSize: 18.0,
    // 该属性用于指定行高，但它并不是一个绝对值，而是一个因子
    // 具体的行高等于 fontSize * height
    height: 1.2,
    // 由于不同平台默认支持的字体集不同
    // 所以在手动指定字体时一定要先在不同平台测试一下
    fontFamily: 'Courier',
    background: Paint()..color = Colors.yellow,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed,
  ),
),
```
<!-- .element: class="fragment" data-fragment-index="2" -->


## TextSpan

Text 的所有文本内容只能指定同一种样式，如果需要对一个 Text 内容的不同部分按照不同的样式显示，这时就可以使用 TextSpan，它代表文本的一个“片段” <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart [2,4-7,9]
const Text.rich(
  TextSpan(
    children: [
      TextSpan(text: 'Home: '),
      TextSpan(
        text: 'https://flutterchina.club',
        style: TextStyle(color: Colors.blue),
        // recognizer: _tapRecognizer,
      ),
    ],
  ),
),
```
<!-- .element: class="fragment" data-fragment-index="2" -->


## DefaultTextStyle

在 Widget 树中，文本的样式默认是可以被继承的（子类文本类组件未指定具体样式时可以使用 Widget 树中父级设置的默认样式）。因此，如果在 Widget 树的某一个节点处设置一个默认的文本样式，那么该节点的子树中所有文本都会默认使用这个样式，而 DefaultTextStyle 正是用于设置默认文本样式的 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart [1|3-6|14-18]
DefaultTextStyle(
  // 设置文本默认样式
  style: const TextStyle(
    color: Colors.red,
    fontSize: 20.0,
  ),
  textAlign: TextAlign.start,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const <Widget>[
      Text('Hello world'),
      Text(
        'Flutter',
        style: TextStyle(
          // 不继承默认样式
          inherit: false,
          color: Colors.grey,
        ),
      ),
    ],
  ),
);
```
<!-- .element: class="fragment" data-fragment-index="2" -->


## 字体

在 Flutter 中使用字体分两步完成：

1. 在 pubspec.yaml 中声明它们，以确保它们会打包到应用程序中 <!-- .element: class="fragment" data-fragment-index="1" -->

```yaml [2-5]
flutter:
  fonts:
    - family: AbrilFatface
      fonts:
        - asset: assets/fonts/abrilfatface/AbrilFatface-Regular.ttf
```
<!-- .element: class="fragment" data-fragment-index="1" -->

2. 然后通过 TextStyle 属性使用字体 <!-- .element: class="fragment" data-fragment-index="2" -->

```dart [2]
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
  // package: 'my_package',
);
```
<!-- .element: class="fragment" data-fragment-index="2" -->



## 按钮

- ElevatedButton <!-- .element: class="fragment" data-fragment-index="1" -->
- TextButton <!-- .element: class="fragment" data-fragment-index="2" -->
- OutlineButton <!-- .element: class="fragment" data-fragment-index="3" -->

Note: 它们都是直接或间接对 RawMaterialButton 组件的包装定制，所以他们大多数属性都和 RawMaterialButton 一样


## ElevatedButton

漂浮按钮，默认带有阴影和灰色背景，按下后，阴影会变大 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
ElevatedButton(
  child: const Text('ElevatedButton'),
  onPressed: () {},
);
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## TextButton

文本按钮，默认背景透明并不带阴影，按下后，会有背景色 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
TextButton(
  child: const Text('TextButton'),
  onPressed: () {},
);
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## OutlinedButton

默认有一个边框，不带阴影且背景透明，按下后，边框颜色会变亮、同时出现背景和阴影 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
OutlinedButton(
  child: const Text('OutlinedButton'),
  onPressed: () {},
);
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## IconButton

IconButton 是一个可点击的 Icon，不包括文字，默认没有背景，点击后会出现背景 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
IconButton(
  icon: const Icon(Icons.thumb_up),
  onPressed: () {},
);
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## 带图标的按钮

ElevatedButton、TextButton、OutlineButton 都有一个 icon 构造函数 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
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
```
<!-- .element: class="fragment" data-fragment-index="1" -->

Note: 通过它可以轻松创建带图标的按钮



## 图片及ICON

我们可以通过 Image 组件来加载并显示图片，Image 的数据源可以是 asset、文件、内存以及网络 <!-- .element: class="fragment r-fit-text" -->


## 从 asset 中加载图片

1. 在工程根目录下创建一个存放资源目录 <!-- .element: class="fragment" data-fragment-index="1" -->
2. 在 pubspec.yaml 中的 flutter 部分添加如下内容 <!-- .element: class="fragment" data-fragment-index="2" -->

```yaml
flutter:
  assets:
    - assets/images/dash.png
```
<!-- .element: class="fragment" data-fragment-index="2" -->

3. 加载该图片 <!-- .element: class="fragment" data-fragment-index="3" -->

```dart
const Image(
  image: AssetImage('assets/images/dash.png'),
  // width: 100.0,
),
Image.asset(
  'assets/images/dash.png',
  width: 100.0,
),
```
<!-- .element: class="fragment" data-fragment-index="3" -->


## 从网络加载图片

```dart
const Image(
  image: NetworkImage(
    'https://b.yzcdn.cn/public_files/683a112c21c0769992671b51afc48389.png',
  ),
  width: double.infinity,
),
Image.network(
  'https://b.yzcdn.cn/public_files/683a112c21c0769992671b51afc48389.png',
  width: 100.0,
),
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## ICON

Flutter 中，可以像 Web 开发一样使用 iconfont，iconfont 即“字体图标”，它是将图标做成字体文件，然后通过指定不同的字符而显示不同的图片 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

iconfont 和图片相比有如下优势 <!-- .element: class="fragment" data-fragment-index="2" -->

- 体积小：可以减小安装包大小 <!-- .element: class="fragment" data-fragment-index="2" -->
- 矢量的：iconfont 都是矢量图标，放大不会影响其清晰度 <!-- .element: class="fragment" data-fragment-index="2" -->
- 可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等 <!-- .element: class="fragment" data-fragment-index="2" -->
- 可以通过 TextSpan 和文本混用 <!-- .element: class="fragment" data-fragment-index="2" -->



## 单选开关和复选框

- Switch <!-- .element: class="fragment" data-fragment-index="1" -->
- Checkbox <!-- .element: class="fragment" data-fragment-index="1" -->



## 输入框及表单

- TextField <!-- .element: class="fragment" data-fragment-index="1" -->
- Form <!-- .element: class="fragment" data-fragment-index="1" -->


## TextField

TextField 用于文本输入 <!-- .element: class="fragment" data-fragment-index="1" -->


## 获取输入内容

1. 定义两个变量，用于保存用户名和密码，然后在 onChange 触发时，各自保存一下输入内容 <!-- .element: class="fragment" data-fragment-index="1" -->
2. 通过 controller 直接获取 <!-- .element: class="fragment" data-fragment-index="1" -->


## 监听文本变化

1. 设置 onChange 回调（专门用于监听文本变化） <!-- .element: class="fragment" data-fragment-index="1" -->
2. 通过 controller 监听（除了能监听文本变化外，还可以设置默认值、选择文本） <!-- .element: class="fragment" data-fragment-index="1" -->


## 控制焦点

焦点可以通过 FocusNode 和 FocusScopeNode 来控制 <!-- .element: class="fragment" data-fragment-index="1" -->


## 监听焦点状态改变事件

FocusNode 继承自 ChangeNotifier，通过 FocusNode 可以监听焦点的改变事件 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
// 创建 focusNode   
FocusNode focusNode = FocusNode();
...
// focusNode 绑定输入框   
TextField(focusNode: focusNode);
...
// 监听焦点变化    
focusNode.addListener((){
  // 获得焦点时 focusNode.hasFocus 值为 true，失去焦点时为 false
  print(focusNode.hasFocus);
});
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## 自定义样式



## 表单 Form

它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->


## Form

Form 继承自 StatefulWidget 对象，它对应的状态类为 FormState <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
Form({
  required Widget child,
  // 是否自动校验输入内容
  // 当为 true 时，每一个子 FormField 内容发生变化时都会自动校验合法性，并直接显示错误信息
  // 否则，需要通过调用 FormState.validate() 来手动校验
  bool autovalidate = false,
  // 决定 Form 所在的路由是否可以直接返回（如点击返回按钮）
  // 该回调返回一个 Future 对象，如果最终结果是 false，则当前路由不会返回；如果为 true，则会返回到上一个路由
  // 此属性通常用于拦截返回按钮
  WillPopCallback onWillPop,
  // Form 的任意一个子 FormField 内容发生变化时会触发此回调
  VoidCallback onChanged,
})
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## FormField

Form 的子孙元素必须是 FormField 类型，FormState 内部通过它们来完成操作 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
const FormField({
  ...
  // 保存回调
  FormFieldSetter<T> onSaved,
  // 验证回调
  FormFieldValidator<T>  validator,
  // 初始值
  T initialValue,
  // 是否自动校验
  bool autovalidate = false,
});
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## FormState

FormState 为 Form 的 State 类，可以通过 Form.of() 或 GlobalKey 获得。我们可以通过它来对 Form 的子孙 FormField 进行统一操作。<!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

- FormState.validate()：调用此方法后，会调用 Form 子孙 FormField 的 validate 回调，如果有一个校验失败，则返回 false，所有校验失败项都会返回用户返回的错误提示 <!-- .element: class="fragment" data-fragment-index="2" -->
- FormState.save()：调用此方法后，会调用 Form 子孙 FormField 的 save 回调，用于保存表单内容 <!-- .element: class="fragment" data-fragment-index="2" -->
- FormState.reset()：调用此方法后，会将子孙 FormField 的内容清空 <!-- .element: class="fragment" data-fragment-index="2" -->



## 进度指示器

Material 组件库中提供了两种进度指示器。它们都可以同时用于精确的进度指示（任务进度可以计算和预估的情况，比如文件下载）和模糊的进度指示（下拉刷新，数据提交） <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

- LinearProgressIndicator <!-- .element: class="fragment" data-fragment-index="2" -->
- CircularProgressIndicator <!-- .element: class="fragment" data-fragment-index="2" -->


## LinearProgressIndicator

一个线性、条状的进度条 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart
LinearProgressIndicator({
  // value 表示当前的进度，取值范围为 [0,1]
  // 如果 value 为 null 时则指示器会执行一个循环动画（模糊进度）
  // 当 value 不为 null 时，指示器为一个具体进度的进度条
  double value,
  // 指示器的背景色
  Color backgroundColor,
  // 指示器的进度条颜色
  // 允许我们对进度条的颜色指定动画
  // 如果我们不需要对进度条颜色执行动画（固定颜色），可以通过 AlwaysStoppedAnimation 来指定
  Animation<Color> valueColor,
  ...
});
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## CircularProgressIndicator

一个圆形进度条 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart
CircularProgressIndicator({
  double value,
  Color backgroundColor,
  Animation<Color> valueColor,
  // 圆形进度条的粗细
  this.strokeWidth = 4.0,
});
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## 自定义尺寸

可以发现 LinearProgressIndicator 和 CircularProgressIndicator，并没有提供设置圆形进度条尺寸的参数 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

如果希望 LinearProgressIndicator 的线细一些，或者希望 CircularProgressIndicator 的圆大一些该怎么做？ <!-- .element: class="fragment r-fit-text" data-fragment-index="2" -->


## 进度色动画


## 自定义进度指示器样式

定制进度指示器风格样式，可以通过 CustomPainter Widget 来自定义绘制逻辑 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

实际上 LinearProgressIndicator 和 CircularProgressIndicator 也正是通过 CustomPainter 来实现外观绘制的 <!-- .element: class="fragment r-fit-text" data-fragment-index="2" -->

[flutter_spinkit](https://pub.flutter-io.cn/packages/flutter_spinkit) <!-- .element: class="fragment" data-fragment-index="3" -->
