import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_flutter/demo/align_route/index.dart';
import 'package:hello_flutter/demo/button_route/index.dart';
import 'package:hello_flutter/demo/constraints_route/index.dart';
import 'package:hello_flutter/demo/flex_route/index.dart';
import 'package:hello_flutter/demo/flow_route/index.dart';
import 'package:hello_flutter/demo/focus_route/index.dart';
import 'package:hello_flutter/demo/form_route/index.dart';
import 'package:hello_flutter/demo/get_state_object_route/index.dart';
import 'package:hello_flutter/demo/image_route/index.dart';
import 'package:hello_flutter/demo/layout_route/index.dart';
import 'package:hello_flutter/demo/progress_indicator_route/index.dart';
import 'package:hello_flutter/demo/row_and_column_route/index.dart';
import 'package:hello_flutter/demo/stack_route/index.dart';
import 'package:hello_flutter/demo/switch_and_checkbox_route/index.dart';
import 'package:hello_flutter/demo/text_route/index.dart';
import 'package:hello_flutter/demo/textfield_route/index.dart';
import 'package:hello_flutter/demo/tip_route/index.dart';
import 'package:hello_flutter/pages/life_cycle/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const ValueKey('HomeListView'),
      restorationId: 'home_list_view',
      children: [
        CupertinoButton(
          child: const Text('TipRoute'),
          onPressed: () async {
            final res = await Navigator.of(context).pushNamed(
              TipRoute.baseRoute,
              arguments: {
                'text': 'hello',
              },
            );
            if (kDebugMode) {
              print(
                  '------------------------------------------>TipRoute 路由返回值: $res');
            }
          },
        ),
        CupertinoButton(
          child: const Text('Get State Object'),
          onPressed: () =>
              Navigator.of(context).pushNamed(GetStateObjectWidget.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Life Cycle'),
          onPressed: () =>
              Navigator.of(context).pushNamed(LifeCyclePage.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Text Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(TextRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Button Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(ButtonRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Image Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(ImageRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('SwitchAndCheckbox Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(SwitchAndCheckboxRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('TextField Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(TextFieldRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Focus Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(FocusRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Form Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(FormRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('ProgressIndicator Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(ProgressIndicatorRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Constraints Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(ConstraintsRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Row And Column Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(RowAndColumnRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Flex Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(FlexRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Flow Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(FlowRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Stack Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(StackRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Align Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(AlignRoute.baseRoute),
        ),
        CupertinoButton(
          child: const Text('Layout Route'),
          onPressed: () =>
              Navigator.of(context).pushNamed(LayoutRoute.baseRoute),
        ),
      ],
    );
  }
}
