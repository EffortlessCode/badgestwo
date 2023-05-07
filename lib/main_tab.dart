import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  // call pick kr
  final List<Tab> topTabs = [
    Tab(
      icon: const Icon(Icons.home_outlined),
    ),
    Tab(
      icon: const Icon(Icons.people),
    ),
    Tab(
      icon: const Icon(Icons.message),
    ),
    Tab(
      icon: Badge(
        isLabelVisible: true,
        label: Text(
          "10+",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        textColor: Colors.white,
        backgroundColor: Colors.red,
        child: const Icon(Icons.notification_add_outlined),
      ),
    ),
    Tab(
      icon: const Icon(Icons.video_call_outlined),
    ),
    Tab(
      icon: const Icon(Icons.shopping_bag_outlined),
    ),

    // Tab(icon: Icon(Icons.shopping_bag_outlined)),
  ];

  @override
  void initState() {
    _tabController =
        TabController(length: topTabs.length, initialIndex: 0, vsync: this)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    print("on Will Pop");
    if (_tabController?.index == 0) {
      await SystemNavigator.pop();
    }
    Future.delayed(Duration(milliseconds: 200), () {
      print('Set Index');
      _tabController?.index = 0;
    });

    print("Return");
    return _tabController?.index == 0;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Facebook',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              child: IconButton(
                icon: Icon(Icons.search),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  print('Search Button CLicked');
                },
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[350],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  icon: Icon(Icons.menu),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => _scaffoldKey.currentState!.openEndDrawer()),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[350],
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            tabs: topTabs,
          ),
        ),
        endDrawer: Container(
          width: MediaQuery.of(context).size.width * 1,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Center(
                child: Text(
              'Home',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              'Friends',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              'Message',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              'Notifications',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              'Video',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(
              'Market Place',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}
