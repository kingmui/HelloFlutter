part of 'index.dart';

typedef PathWidgetBuilder = Widget Function(
    BuildContext, Map<dynamic, dynamic>);

class Path {
  const Path(this.baseRoute, this.builder);

  final String baseRoute;
  final PathWidgetBuilder builder;
}

List<Path> paths = [
  Path(
    TipRoute.baseRoute,
    (context, arguments) => TipRoute(text: arguments['text'] as String),
  ),
  Path(
    GetStateObjectWidget.baseRoute,
    (context, arguments) => const GetStateObjectWidget(),
  ),
  Path(
    LifeCyclePage.baseRoute,
    (context, arguments) => const LifeCyclePage(),
  ),
  Path(
    TextRoute.baseRoute,
    (context, arguments) => const TextRoute(),
  ),
  Path(
    ButtonRoute.baseRoute,
    (context, arguments) => const ButtonRoute(),
  ),
  Path(
    ImageRoute.baseRoute,
    (context, arguments) => const ImageRoute(),
  ),
  Path(
    SwitchAndCheckboxRoute.baseRoute,
    (context, arguments) => const SwitchAndCheckboxRoute(),
  ),
  Path(
    TextFieldRoute.baseRoute,
    (context, arguments) => const TextFieldRoute(),
  ),
  Path(
    FocusRoute.baseRoute,
    (context, arguments) => const FocusRoute(),
  ),
  Path(
    FormRoute.baseRoute,
    (context, arguments) => const FormRoute(),
  ),
  Path(
    ProgressIndicatorRoute.baseRoute,
    (context, arguments) => const ProgressIndicatorRoute(),
  ),
  Path(
    ConstraintsRoute.baseRoute,
    (context, arguments) => const ConstraintsRoute(),
  ),
  Path(
    RowAndColumnRoute.baseRoute,
    (context, arguments) => const RowAndColumnRoute(),
  ),
  Path(
    FlexRoute.baseRoute,
    (context, arguments) => const FlexRoute(),
  ),
  Path(
    FlowRoute.baseRoute,
    (context, arguments) => const FlowRoute(),
  ),
  Path(
    StackRoute.baseRoute,
    (context, arguments) => const StackRoute(),
  ),
  Path(
    AlignRoute.baseRoute,
    (context, arguments) => const AlignRoute(),
  ),
  Path(
    LayoutRoute.baseRoute,
    (context, arguments) => LayoutRoute(),
  ),
  Path(
    initialRoute,
    (context, arguments) => const MainScreenPage(),
  ),
];
