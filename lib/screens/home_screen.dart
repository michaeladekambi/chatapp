import 'package:ChatApp/app.dart';
import 'package:ChatApp/pages/calls_page.dart';
import 'package:ChatApp/pages/messages_page.dart';
import 'package:ChatApp/pages/notification_page.dart';
import 'package:ChatApp/screens/profile_screen.dart';
import 'package:ChatApp/widgets/avatar.dart';
import 'package:ChatApp/widgets/glowing_action_button.dart';
import 'package:ChatApp/widgets/icon_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers.dart';
import '../pages/contacts_page.dart';
import '../theme.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');
  final pages = [
    const MessagesPage(),
    const NotificationPage(),
    const CallsPage(),
    const ContactsPage(),
  ];

  final pageTitles = [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts'
  ];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, value, _) {
            return Text(
              title.value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          },
        ),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
              icon: Icons.search,
              onTap: () {}
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Hero(
              tag: 'her0-profile-picture',
              child: Avatar.small(
                  url: context.currentUserImage,
                onTap: () {
                    Navigator.of(context).push(ProfileScreen.route);
                },
              ),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }


}


class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    super.key,
    required this.onItemSelected
  });

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {

  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      margin: const EdgeInsets.all(0),
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      child: SafeArea(
        top: false,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  label: 'Messages',
                  icon: CupertinoIcons.bubble_left_bubble_right_fill,
                  index: 0,
                  onTap: handleItemSelected,
                  isSelected: (selectedIndex==0),
                ),
                _NavigationBarItem(
                  label: 'Notification',
                  icon: CupertinoIcons.bell_solid,
                  index: 1,
                  onTap: handleItemSelected ,
                  isSelected: (selectedIndex == 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: GlowingActionButton(
                      color: AppColors.secondary
                      , icon: CupertinoIcons.add,
                      onPressed: () {
                        showDialog(
                            context: context
                            , builder: (BuildContext context) => const Dialog(
                              child: AspectRatio(
                                  aspectRatio: 8/7,
                                child: ContactsPage(),
                              ),
                           )
                        );
                      }
                  ),
                ),
                _NavigationBarItem(
                  label: 'Calls',
                  icon: CupertinoIcons.phone_fill,
                  index: 2,
                  onTap: handleItemSelected,
                  isSelected: (selectedIndex ==2) ,
                ),
                _NavigationBarItem(
                  label: 'Contacts',
                  icon: CupertinoIcons.person_2_fill,
                  index: 3,
                  onTap: handleItemSelected,
                  isSelected: (selectedIndex==3),
                ),
              ],
            ),
          )
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
   const _NavigationBarItem({super.key,
    required this.label,
    required this.icon,
     required this.index,
     required this.onTap,
     this.isSelected = false
  });

  final String label;
  final IconData icon;
  final int index;
  final bool isSelected;

  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(height: 8,),
            Text(
              label,
              style: isSelected ?
              const TextStyle(
                  fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary
              ) :
              const TextStyle(
                  fontSize: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}
