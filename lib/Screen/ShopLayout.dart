import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screen/LogIn/LoginScreen.dart';
import 'package:shop_app/Screen/search/searchScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shop_app/Theme/theme.dart';
import '../Cubit/cubit.dart';
import '../Cubit/state.dart';
import '../imp_func.dart';

class ShopLayoutScreen extends StatelessWidget {
  List<PersistentBottomNavBarItem> navbarItems = [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorSecondary: Colors.white,
        activeColorPrimary: primaryClr),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        title: "Categories",
        activeColorSecondary: Colors.white,
        activeColorPrimary: primaryClr),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: "Favorite",
        activeColorSecondary: Colors.white,
        activeColorPrimary: primaryClr),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorSecondary: Colors.white,
        activeColorPrimary: primaryClr),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessLogOutState) {
          go_toAnd_finish(context, LoginScreen());
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        PersistentTabController controller =
            PersistentTabController(initialIndex: cubit.CurrentIndex);
        return Scaffold(
          appBar: AppBar(
            title: cubit.CurrentIndex == 0
                ? const Text("Home")
                : cubit.CurrentIndex == 1
                    ? const Text("Categories")
                    : cubit.CurrentIndex == 2
                        ? const Text("Favorite")
                        : const Text("Settings"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    go_to(context,  SearchScreen());
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: PersistentTabView(
            context,
            screens: cubit.BottomScreens,
            items: navbarItems,
            navBarStyle: NavBarStyle.style7,
            onItemSelected: (value) {
              cubit.ChangeBottom(value);
            },
            controller: controller,
            screenTransitionAnimation: const ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 200),
            ),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: cubit.CurrentIndex,
          //   items: const [
          //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.apps), label: "Categories"),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.favorite), label: "Favorite"),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.settings), label: "Settings"),
          //   ],
          //   onTap: (value) {
          //     cubit.ChangeBottom(value);
          //   },
          // ),
        );
      },
    );
  }
}
