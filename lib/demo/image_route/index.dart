import 'package:flutter/material.dart';

/// Flutter 中，我们可以通过 Image 组件来加载并显示图片，Image 的数据源可以是 asset、文件、内存以及网络
/// ImageProvider
/// ImageProvider 是一个抽象类，主要定义了图片数据获取的接口 load()
/// 从不同的数据源获取图片需要实现不同的 ImageProvider
/// 如 AssetImage 是实现了从 Asset 中加载图片的 ImageProvider
/// 而 NetworkImage 则实现了从网络加载图片的 ImageProvider
///
/// Flutter 中，可以像 Web 开发一样使用 iconfont
/// iconfont 即「字体图标」，它是将图标做成字体文件，然后通过指定不同的字符而显示不同的图片
/// 在字体文件中，每一个字符都对应一个位码，而每一个位码对应一个显示字形，不同的字体就是指字形不同，即字符对应的字形是不同的
/// 而在 iconfont 中，只是将位码对应的字形做成了图标，所以不同的字符最终就会渲染成不同的图标
///
/// iconfont 和图片相比有如下优势：
/// 1. 体积小：可以减小安装包大小
/// 2. 矢量的：iconfont 都是矢量图标，放大不会影响其清晰度
/// 3. 可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等
/// 4. 可以通过 TextSpan 和文本混用

class ImageRoute extends StatelessWidget {
  const ImageRoute({Key? key}) : super(key: key);

  static const String baseRoute = '/image_route';

  final img = const AssetImage('assets/images/yuanyuan.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片及ICON'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                // Image widget 有一个必选的 image 参数，它对应一个 ImageProvider
                image: AssetImage('assets/images/dash.png'),
                // width: 100.0,
              ),
              // Image 也提供了一个快捷的构造函数 Image.asset 用于从 asset 中加载、显示图片
              Image.asset(
                'assets/images/dash.png',
                width: 100.0,
              ),
              const Image(
                image: NetworkImage(
                  'https://b.yzcdn.cn/public_files/683a112c21c0769992671b51afc48389.png',
                ),
                width: double.infinity,
              ),
              // Image 也提供了一个快捷的构造函数 Image.network 用于从网络加载、显示图片
              Image.network(
                'https://b.yzcdn.cn/public_files/683a112c21c0769992671b51afc48389.png',
                width: 100.0,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                '图片伸缩示例',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...<Image>[
                Image(
                  image: img,
                  height: 50.0,
                  width: 100.0,
                  // 在图片的显示空间和图片本身大小不同时指定图片的适应模式
                  // 会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形
                  fit: BoxFit.fill,
                ),
                Image(
                  image: img,
                  height: 50,
                  width: 50.0,
                  // 默认规则，会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形
                  fit: BoxFit.contain,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 50.0,
                  // 会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁
                  fit: BoxFit.cover,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 50.0,
                  // 图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁
                  fit: BoxFit.fitWidth,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 50.0,
                  // 图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁
                  fit: BoxFit.fitHeight,
                ),
                Image(
                  image: img,
                  height: 50.0,
                  width: 100.0,
                  // 图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分
                  fit: BoxFit.none,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  // 在图片绘制时可以对每一个像素进行颜色混合处理
                  // 指定混合色
                  color: Colors.blue,
                  // 指定混合模式
                  colorBlendMode: BlendMode.difference,
                  fit: BoxFit.fill,
                ),
                Image(
                  image: img,
                  width: 100.0,
                  height: 200.0,
                  // 当图片本身大小小于显示空间时，指定图片的重复规则
                  repeat: ImageRepeat.repeatY,
                )
              ].map((child) {
                return Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        child: child,
                      ),
                    ),
                    Text(
                      child.fit.toString(),
                    )
                  ],
                );
              }).toList(),
              const Text(
                'Icon',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Text(
                '\uE03e \uE237 \uE287',
                style: TextStyle(
                  fontFamily: 'MaterialIcons',
                  fontSize: 24.0,
                  color: Colors.green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  // Icons 类中包含了所有 Material Design 图标的 IconData 静态变量定义
                  Icon(Icons.accessible, color: Colors.green),
                  Icon(Icons.error, color: Colors.green),
                  Icon(Icons.fingerprint, color: Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
