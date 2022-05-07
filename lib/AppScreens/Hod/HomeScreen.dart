import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lm_hod/AppScreens/Hod/Announcement.dart';
import 'package:lm_hod/AppScreens/Hod/LeaveHistory.dart';
import 'package:lm_hod/AppScreens/Hod/StaffDismissal.dart';
import 'package:lm_hod/AppScreens/Hod/StaffRecruit.dart';
import 'package:lm_hod/AppScreens/Hod/TodayLeaveApplicants.dart';
import 'package:lm_hod/Models/Hod/HodModel.dart';
import 'package:lm_hod/Providers/Hod%20provider/HodProvider.dart';
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lm_hod/AppScreens/HOD/LoginScreen.dart';
import 'package:lm_hod/Resources/HodAuthMethods.dart';
import 'package:lm_hod/ReusableUtils/Side transition.dart';
import 'package:lm_hod/ReusableUtils/Heightwidth.dart' as height_width;
import 'package:lm_hod/ReusableUtils/Responsive.dart';

import 'package:provider/provider.dart';

import '../../ReusableUtils/HeightWidth.dart';
import '../../ReusableUtils/HomePageContainer/HomePageContainer.dart';
import '../../ReusableUtils/PageView/PageView.dart';
import '../../ReusableUtils/SideBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addHodData() async {
    HodProvider _hodProvider = Provider.of(context,listen: false);
    await _hodProvider.refreshHod();
  }
  @override
  void initState(){
    if(mounted) {
      super.initState();
      addHodData();
    }
  }
  @override
  void dispose(){
    super.dispose();
  }
  void logoutHod() async{
    String finalResult = await AuthMethods().logoutHod();
    if(finalResult == "success"){
      Navigator.pushReplacement(context, CustomPageRouteSide(child: const LoginScreen()));
    }
  }
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    HodModel hodModel = Provider.of<HodProvider>(context).getHod;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: const SideBar(),
        backgroundColor: color_mode.primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                floating: false,
                snap: false,
                backgroundColor: color_mode.secondaryColor2,
                shadowColor: color_mode.tertiaryColor,
                elevation: 2,
                expandedHeight: getHeight(context) / 2.8,
                flexibleSpace: const FlexibleSpaceBar(
                  background: ScrollPageView(),
                )),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenLayout(30, context),
                    vertical: screenLayout(30, context)),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenLayout(80, context),),
                          Padding(
                            padding: EdgeInsets.only(left: screenLayout(20, context)),
                            child: Text(
                              "All Services",
                              style: TextStyle(
                                  color: color_mode.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenLayout(40, context),
                                  letterSpacing: 1.5),
                            ),
                          ),
                          SizedBox(
                            height: screenLayout(40, context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Wrap(
                              runSpacing: screenLayout(20, context),
                              spacing: screenLayout((getWidth(context) >= 390)?50:40, context),
                              children: [
                                homeContainer(
                                    context: context,
                                    description: "Department announcement",
                                    heading: "Announcement",
                                    icon: FontAwesomeIcons.bell,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const Announcement()));
                                    }),
                                homeContainer(
                                    context: context,
                                    description: "Approve Teacher leave",
                                    heading: "Leave Approval",
                                    icon: FontAwesomeIcons.newspaper,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=> const LeaveApplicants()));
                                    }),
                                homeContainer(
                                    context: context,
                                    description: "Add department staff",
                                    heading: "Staff Recruit",
                                    icon: FontAwesomeIcons.person,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>const StaffRecruit()));
                                    }),
                                homeContainer(
                                    context: context,
                                    description: "Dismiss staff from department",
                                    heading: "Staff Dismissal",
                                    icon: FontAwesomeIcons.crosshairs,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const StaffDismissal()));
                                    }),
                                homeContainer(
                                    context: context,
                                    description: "Staff Leave History",
                                    heading: "Leave History",
                                    icon: FontAwesomeIcons.peopleGroup,
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveHistory()));
                                    }),

                              ],
                            ),
                          ),
                          SizedBox(height: screenLayout(100, context),),
                        ],
                      );
                    }, childCount: 1)),
          ],
        ),
      ),
    );
  }
}

