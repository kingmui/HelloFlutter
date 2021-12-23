# 基础组件

- 文本和样式 <!-- .element: class="fragment" data-fragment-index="1" -->
- 按钮 <!-- .element: class="fragment" data-fragment-index="2" -->
- 图片和 Icon <!-- .element: class="fragment" data-fragment-index="3" -->
- 单选框和复选框 <!-- .element: class="fragment" data-fragment-index="4" -->
- 输入框和表单 <!-- .element: class="fragment" data-fragment-index="5" -->
- 进度指示器 <!-- .element: class="fragment" data-fragment-index="6" -->



## 文本和样式


## Text

用于显示简单的样式文本 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart [3,7-8,12]
Text('Hello world',
  // 对齐的参考系是 Text widget 本身
  textAlign: TextAlign.left,
);

Text("Hello world! I'm Jack. "*4,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
);

Text('Hello world',
  textScaleFactor: 1.5,
);
```
<!-- .element: class="fragment" data-fragment-index="2" -->

Note: 介绍 textAlign（center）、maxLines、overflow、textScaleFactor 属性


## 前端实现文本溢出效果

```css [3-5|10-14]
/*单行溢出*/
.one-txt-cut {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

/*多行溢出*/
.txt-cut {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}
```


## TextStyle

用于指定文本显示的样式。如颜色、字体、粗细、背景等 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

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
);
```
<!-- .element: class="fragment" data-fragment-index="2" -->

Note: fontSize 和 textScaleFactor 区别


## TextSpan

Text 的所有文本内容只能指定同一种样式，如果需要对一个 Text 内容的不同部分按照不同的样式显示，这时就可以使用 TextSpan，它代表文本的一个「片段」 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart [2-15]
Text.rich(
  TextSpan(
    // TextSpan 数组，可以包括其他 TextSpan
    children: <TextSpan>[
      const TextSpan(text: 'Flutter: '),
      TextSpan(
        // 文本片段内容
        text: 'https://flutter.dev/',
        // 文本片段样式
        style: const TextStyle(color: Colors.blue),
        // 用于对该文本片段上的手势进行识别处理
        recognizer: _tapRecognizer,
      ),
    ],
  ),
),
```
<!-- .element: class="fragment" data-fragment-index="2" -->


## DefaultTextStyle

用于设置默认文本样式
<!-- .element: class="fragment" data-fragment-index="1" -->

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

Note: 在 Widget 树中，文本的样式默认是可以被继承的（子类可以使用 Widget 树中父级设置的默认样式）。如果在 Widget 树的某一个节点设置默认的文本样式，该节点的子树中所有文本都会默认使用这个样式


## 字体

在 Flutter 中使用字体分两步完成：

1. 在 pubspec.yaml 中声明它们，以确保它们会打包到应用程序中 <!-- .element: class="fragment" data-fragment-index="1" -->

```yaml [2-5]
flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: assets/fonts/Raleway/Raleway.ttf
```
<!-- .element: class="fragment" data-fragment-index="1" -->

2. 然后通过 TextStyle 属性使用字体 <!-- .element: class="fragment" data-fragment-index="2" -->

```dart [2]
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
  // 要使用 Package 中定义的字体，必须提供 package 参数
  // package: 'my_package',
);
```
<!-- .element: class="fragment" data-fragment-index="2" -->

Note: 要将字体文件打包到应用中，和使用其它资源一样，要先在 pubspec.yaml 中声明它。然后将字体文件复制到指定的位置



## 按钮

- ElevatedButton <!-- .element: class="fragment" data-fragment-index="1" -->
- TextButton <!-- .element: class="fragment" data-fragment-index="1" -->
- OutlineButton <!-- .element: class="fragment" data-fragment-index="1" -->

Note: 它们都是直接或间接对 RawMaterialButton 组件的包装定制，所以他们大多数属性都和 RawMaterialButton 一样


## ElevatedButton

漂浮按钮，默认带有阴影和灰色背景，按下后，阴影会变大 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
ElevatedButton(
  child: const Text('ElevatedButton'),
  // 设置点击回调，当按钮按下时会执行该回调
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

默认有一个边框，不带阴影且背景透明 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart
OutlinedButton(
  child: const Text('OutlinedButton'),
  onPressed: () {},
);
```
<!-- .element: class="fragment" data-fragment-index="1" -->

Note: 按下后，边框颜色会变亮、同时出现背景和阴影


## IconButton

IconButton 是一个可点击的 Icon，不包括文字 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart
IconButton(
  icon: const Icon(Icons.thumb_up),
  onPressed: () {},
);
```
<!-- .element: class="fragment" data-fragment-index="1" -->

Note: 默认没有背景，点击后会出现背景


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

通过 Image 组件来加载并显示图片 <!-- .element: class="fragment" data-fragment-index="1" -->

Note: Image 的数据源可以是 asset、文件、内存以及网络


## ImageProvider

一个抽象类，定义了图片数据获取的接口 load() <!-- .element: class="fragment" data-fragment-index="1" -->

Note: 从不同的数据源获取图片需要实现不同的 ImageProvider，如 AssetImage 是实现了从 Asset 中加载图片的 ImageProvider，而 NetworkImage 实现了从网络加载图片的 ImageProvider


## 从 asset 中加载图片

1. 在工程根目录下创建一个存放资源目录 <!-- .element: class="fragment" data-fragment-index="1" -->

```bash
.
├── assets
│   └── images
│       └── dash.jpg
```
<!-- .element: class="fragment" data-fragment-index="1" -->

2. 在 pubspec.yaml 中的 flutter 部分添加如下内容 <!-- .element: class="fragment" data-fragment-index="2" -->

```yaml
flutter:
  assets:
    - assets/images/
```
<!-- .element: class="fragment" data-fragment-index="2" -->

3. 加载该图片 <!-- .element: class="fragment" data-fragment-index="3" -->

```dart
const Image(image: AssetImage('assets/images/dash.png'),),
Image.asset('assets/images/dash.png'),
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

可以像 Web 开发一样使用 iconfont，它是将图标做成字体文件，然后通过指定不同的字符而显示不同的图片 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

iconfont 和图片相比有如下优势 <!-- .element: class="fragment" data-fragment-index="2" -->

- 体积小：可以减小安装包大小 <!-- .element: class="fragment" data-fragment-index="2" -->
- 矢量的：放大不会影响其清晰度 <!-- .element: class="fragment" data-fragment-index="2" -->
- 应用文本样式：像文本一样改变字体图标的颜色、大小对齐等 <!-- .element: class="fragment" data-fragment-index="2" -->
- 可以通过 TextSpan 和文本混用 <!-- .element: class="fragment" data-fragment-index="2" -->


## IconStore

[iconstore](https://design.qima-inc.com/#/iconstore)


## 使用 [IconStore Flutter](https://gitlab.qima-inc.com/meijing/iconstore-flutter) 组件

1. 安装 <!-- .element: class="fragment" data-fragment-index="1" -->

```shell
flutter pub add iconstore --hosted-url=http://flutterpub.qa.s.qima-inc.com
```
<!-- .element: class="fragment" data-fragment-index="1" -->

2. 使用 <!-- .element: class="fragment" data-fragment-index="2" -->

```dart [1,8-12]
import 'package:iconstore/iconstore.dart';

class IconStoreDemo extends StatelessWidget {
  const IconStoreDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconStore(
      codePoint: IconStores.weChat,
      size: 50,
      color: Colors.green,
    );
  }
}
```
<!-- .element: class="fragment" data-fragment-index="2" -->



## 单选开关和复选框

- Switch <!-- .element: class="fragment" data-fragment-index="1" -->
- Checkbox <!-- .element: class="fragment" data-fragment-index="1" -->



## 输入框及表单

- TextField <!-- .element: class="fragment" data-fragment-index="1" -->
- Form <!-- .element: class="fragment" data-fragment-index="1" -->

Note: Material 组件库中提供了输入框组件 TextField 和表单组件 Form


## TextField

用于文本输入 <!-- .element: class="fragment" data-fragment-index="1" -->


## 获取输入内容

1. 定义两个变量，用于保存用户名和密码，然后在 onChange 触发时，各自保存一下输入内容 <!-- .element: class="fragment" data-fragment-index="1" -->
2. 通过 controller 直接获取 <!-- .element: class="fragment" data-fragment-index="1" -->


## 监听文本变化

1. 设置 onChange 回调（专门用于监听文本变化） <!-- .element: class="fragment" data-fragment-index="1" -->
2. 通过 controller 监听（除了能监听文本变化外，还可以设置默认值、选择文本） <!-- .element: class="fragment" data-fragment-index="1" -->


## 控制焦点

焦点可以通过 FocusNode 和 FocusScopeNode 来控制 <!-- .element: class="fragment" data-fragment-index="1" -->

Note: 默认情况下，焦点由 FocusScope 来管理，它代表焦点控制范围，可以在这个范围内通过 FocusScopeNode 在输入框之间移动焦点、设置默认焦点等。


## 监听焦点状态改变事件

FocusNode 继承自 ChangeNotifier，通过 FocusNode 可以监听焦点的改变事件 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart
class FocusNode with DiagnosticableTreeMixin, ChangeNotifier {}

// 创建 focusNode
FocusNode focusNode = FocusNode();

// focusNode 绑定输入框
TextField(focusNode: focusNode);

// 监听焦点变化    
focusNode.addListener((){
  // 获得焦点时 focusNode.hasFocus 值为 true，失去焦点时为 false
  print(focusNode.hasFocus);
});
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## 自定义样式

我们可以通过 decoration 属性来定义输入框样式 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart [2-14]
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
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## 自定义下划线宽度

TextField 无法直接定义下划线宽度 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart [3-7]
// 可以通过隐藏掉 TextField 本身的下划线，然后通过 Container 去嵌套定义样式
Container(
  decoration: const BoxDecoration(
    border: Border(
      bottom: BorderSide(color: Colors.green, width: 1.0,),
    ),
  ),
  child: const TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: '邮箱',
      hintText: '电子邮件地址',
      prefixIcon: Icon(Icons.email),
      border: InputBorder.none,
    ),
  ),
),
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## 表单 Form

它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

Note: 实际业务中，在正式向服务器提交数据前，都会对各个输入框数据进行合法性校验，但是对每一个 TextField 都分别进行校验将会是一件很麻烦的事。如果用户想清除一组 TextField 的内容，除了一个一个清除有没有什么更好的办法呢？


## Form

Form 继承自 StatefulWidget 对象，它对应的状态类为 FormState <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

```dart [6-12]
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
  // 保存回调
  FormFieldSetter<T> onSaved,
  // 验证回调
  FormFieldValidator<T> validator,
  // 初始值
  T initialValue,
  // 是否自动校验
  bool autovalidate = false,
});
```
<!-- .element: class="fragment" data-fragment-index="1" -->

Note: 为了方便使用，Flutter 提供了一个 TextFormField 组件，它继承自 FormField 类，也是 TextField 的一个包装类，所以除了 FormField 定义的属性之外，它还包括 TextField 的属性


## FormState

FormState 为 Form 的 State 类，可以通过 Form.of() 或 GlobalKey 获得 <!-- .element: class="fragment r-fit-text" data-fragment-index="1" -->

- FormState.validate()：会调用 Form 子孙 FormField 的 validate 回调，如果有一个校验失败，则返回 false，所有校验失败项都会返回用户返回的错误提示 <!-- .element: class="fragment" data-fragment-index="2" -->
- FormState.save()：会调用 Form 子孙 FormField 的 save 回调，用于保存表单内容 <!-- .element: class="fragment" data-fragment-index="2" -->
- FormState.reset()：会将子孙 FormField 的内容清空 <!-- .element: class="fragment" data-fragment-index="2" -->

Note: 我们可以通过它来对 Form 的子孙 FormField 进行统一操作



## 进度指示器

Material 组件库中提供了两种进度指示器 <!-- .element: class="fragment" data-fragment-index="1" -->

- LinearProgressIndicator <!-- .element: class="fragment" data-fragment-index="1" -->
- CircularProgressIndicator <!-- .element: class="fragment" data-fragment-index="1" -->

Note: 它们都可以同时用于精确的进度指示（任务进度可以计算和预估的情况，比如文件下载）和模糊的进度指示（下拉刷新，数据提交）


## LinearProgressIndicator

一个线性、条状的进度条 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart [5-11]
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
});
```
<!-- .element: class="fragment" data-fragment-index="1" -->


## CircularProgressIndicator

一个圆形进度条 <!-- .element: class="fragment" data-fragment-index="1" -->

```dart [2-6]
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

这两种进度条都没有提供设置进度条尺寸的参数 <!-- .element: class="fragment" data-fragment-index="1" -->

如果希望 LinearProgressIndicator 的线细一些，或者希望 CircularProgressIndicator 的圆大一些该怎么做？ <!-- .element: class="fragment r-fit-text" data-fragment-index="2" -->

Note: LinearProgressIndicator 和 CircularProgressIndicator 都是取父容器的尺寸作为绘制的边界的。我们可以通过尺寸限制类 Widget，如 ConstrainedBox、SizedBox 来指定尺寸


## 进度色动画

可以通过 valueColor 对进度条颜色做动画 <!-- .element: class="fragment" data-fragment-index="1" -->
