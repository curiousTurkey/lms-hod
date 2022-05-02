import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lm_hod/AppScreens/Hod/Announcement.dart';
import 'package:lm_hod/AppScreens/Hod/LeaveHistory.dart';
import 'package:lm_hod/AppScreens/Hod/Profile.dart';
import 'package:lm_hod/Providers/Hod%20provider/HodProvider.dart';
import 'package:lm_hod/ReusableUtils/Colors.dart' as color_mode;
import 'package:lm_hod/ReusableUtils/Responsive.dart';
import 'package:provider/provider.dart';
import 'HomeScreen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  late PageController pageController ;

  addHodData() async {
    HodProvider _hodProvider = Provider.of(context,listen: false);
    await _hodProvider.refreshHod();
  }
  @override
  void initState(){
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    addHodData();

  }
  void onTap(index){
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 50), curve: Curves.linearToEaseOut);
    });
  }
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(value: SystemUiOverlayStyle(
        systemNavigationBarColor: color_mode.secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light),
      child:Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (selectedIndex){
            setState(() {
              this.selectedIndex = selectedIndex;
            });
          },
          children: const [
            HomeScreen(),
            Announcement(),
            LeaveHistory(),
            ProfilePage(),

                   ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          onTap: onTap,
          backgroundColor: color_mode.primaryColor,
          elevation: 5,
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: color_mode.secondaryColor),
          selectedIconTheme: IconThemeData(
            color: color_mode.primaryColor,
            opacity: 1,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
            opacity: 1,
          ),
          currentIndex: selectedIndex,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon:  Icon(FontAwesomeIcons.house, size: screenLayout(30, context),),
              label: "Home",
              activeIcon: Icon(Icons.home,size: screenLayout(43, context),color: color_mode.secondaryColor2,),
              backgroundColor: color_mode.primaryColor,
            ),
            BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.microphoneLines),
                label: 'Announcement',
                activeIcon: FaIcon(FontAwesomeIcons.microphone , color: color_mode.secondaryColor2,),
                backgroundColor: color_mode.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.history),
              label: "Leave History",
              activeIcon:FaIcon(FontAwesomeIcons.history,color: color_mode.secondaryColor2,),
              backgroundColor: color_mode.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_outlined),
              label: "Profile",
              activeIcon:Icon(Icons.person,color: color_mode.secondaryColor2,),
              backgroundColor: color_mode.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
