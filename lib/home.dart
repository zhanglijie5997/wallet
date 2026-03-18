import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:wallet_project/chat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ReownAppKitModal _appKitModal;

  ChatUser user = ChatUser(id: '1', firstName: 'Charles', lastName: 'Leclerc');

  late List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(text: 'Hey!', user: user, createdAt: DateTime.now()),
  ];

  @override
  void initState() {
    _loadItems();
    super.initState();
    _appKitModal = ReownAppKitModal(
      context: context,
      projectId: '417864fbc830f0a52d6fc2e90af12491',
      metadata: const PairingMetadata(
        name: 'Example App',
        description: 'Example app description',
        url: 'https://reown.com/',
        icons: ['https://reown.com/logo.png'],
        redirect: Redirect(
          native: 'exampleapp://',
          universal: 'https://reown.com/exampleapp',
        ),
      ),
    );
    _appKitModal.addListener(listener);
    _appKitModal.init().then((value) => setState(() {}));
  }

  listener() {}

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  final List<int> _items = []; // 初始为空
  final int _totalItems = 12; // 最终要显示的条目数

  void _loadItems() async {
    for (int i = 0; i < _totalItems; i++) {
      // 1. 稍微延迟，制造“一个接一个”的效果
      await Future.delayed(const Duration(milliseconds: 80));

      // 2. 更新数据源
      _items.add(i);

      // 3. 通知 Grid 执行动画
      _gridKey.currentState?.insertItem(
        i,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  Widget _buildCard(int index) {
    return Card(
      color: Colors.blueAccent,
      child: Center(
        child: Text("Item $index", style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: ,
      // body: SliverAnimatedListExample()
      body: AnimatedGrid(
        key: _gridKey,
        itemBuilder: (context, index, animation) {
          // 定义从下往上的偏移：Offset(0, 1) 代表从下方一个自身高度开始
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 0.5), // 0.3 代表偏移 30% 的高度，下沉感较自然
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: _buildCard(index)),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
      // body: Stack(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(bottom: 80),
      //       child: CustomScrollView(
      //         slivers: [
      //           SliverToBoxAdapter(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Visibility(
      //                   visible: _appKitModal.isConnected,
      //                   child: AppKitModalAccountButton(
      //                     appKitModal: _appKitModal,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),

      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
