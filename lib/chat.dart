import 'package:flutter/material.dart';

class SliverAnimatedListExample extends StatefulWidget {
  @override
  _SliverAnimatedListExampleState createState() => _SliverAnimatedListExampleState();
}

class _SliverAnimatedListExampleState extends State<SliverAnimatedListExample> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();
  final List<String> _items = ['第一条', '第二条'];

  void _addItem() {
    final index = _items.length;
    _items.add('新消息 ${index + 1}');
    _listKey.currentState?.insertItem(index);
  }

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
    );
  }

  Widget _buildItem(String text, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SizeTransition(
        sizeFactor: animation,
        child: Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(text),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeItem(_items.indexOf(text)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // iOS 风格的大标题导航栏
          const SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(title: Text('Sliver 动画列表')),
            floating: true,
          ),
          // 动画列表主体
          SliverAnimatedList(
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(_items[index], animation);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}