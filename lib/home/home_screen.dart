import 'package:bababos_test/cart/cart_screen.dart';
import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:bababos_test/commons/ui/base_scaffold.dart';
import 'package:bababos_test/product_list/product_list_screen.dart';
import 'package:bababos_test/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _showingScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_showingScreenIndex) {
      case 0:
        body = const ProductListScreen();
        break;
      case 1:
        body = CartScreen(
          openProductList: () => setState(() {
            _showingScreenIndex = 0;
          }),
        );
        break;
      default:
        body = const ProfileScreen();
    }

    return BaseScaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(
              "assets/images/small_logo.svg",
              height: 20.0,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              _constructDrawerItem(
                title: "Product List",
                icon: Icons.shopping_bag_outlined,
                index: 0,
              ),
              _constructDrawerItem(
                title: "Cart",
                icon: Icons.shopping_cart_outlined,
                index: 1,
              ),
              _constructDrawerItem(
                title: "Profile",
                icon: Icons.supervised_user_circle_outlined,
                index: 2,
              )
            ],
          ),
        ),
      ),
      body: body,
    );
  }

  Widget _constructDrawerItem({
    required String title,
    required IconData icon,
    required int index,
  }) {
    return ListTile(
      title: Text(title),
      selected: _showingScreenIndex == index,
      selectedColor: BaseColors.lightPurple,
      selectedTileColor: BaseColors.purple,
      textColor: BaseColors.darkGrey,
      leading: SizedBox(
        width: 20.0,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            icon,
            size: 20.0,
          ),
        ),
      ),
      minLeadingWidth: 20.0,
      onTap: () {
        setState(() {
          _showingScreenIndex = index;
        });
        Navigator.of(context).pop();
      },
    );
  }
}
