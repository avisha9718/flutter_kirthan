import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_kirthan/view_models/main_page_view_model.dart';
import 'package:flutter_kirthan/views/widgets/users_panel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  final MainPageViewModel viewModel;

  MainPage({Key key, @required this.viewModel}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  Future loadData() async {
    await widget.viewModel.setSuperAdminUsers("SuperAdmin");
    await widget.viewModel.setAllUsers("All");
    //await widget.viewModel.setUserdetails();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'User Management',
          style: TextStyle(
            fontFamily: 'Distant Galaxy',
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 2.0,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.supervisor_account),
                child: const Text("Super Admin"),),
            Tab(icon: Icon(FontAwesomeIcons.users),
              child: const Text("Users"),),
            //Tab(icon: Icon(FontAwesomeIcons.globeAmericas))
          ],
        ),
      ),
      body: ScopedModel<MainPageViewModel>(
        model: widget.viewModel,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            UsersPanel(userType: "SuperAdmin",),
            UsersPanel(userType: "All",),
            //UsersPanel(),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}