// GENERATED ROUTES - 由脚本生成，若要替换为真实页面，请编辑此文件。
import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  final String name;
  const PlaceholderPage(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text('请实现页面: $name')),
    );
  }
}

/// 应用路由映射（基于 lib/pages 的顶层文件夹自动生成）
final Map<String, WidgetBuilder> appRoutes = {
  '/home': (context) => const PlaceholderPage('home'),
  '/find': (context) => const PlaceholderPage('find'),
  '/me': (context) => const PlaceholderPage('me'),
};
