import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onTapCategory, onTapHotNews, onTapBreakingNews;
  const CustomDrawer(
      {super.key,
      required this.onTapCategory,
      required this.onTapHotNews,
      required this.onTapBreakingNews});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.navItemsBackground,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.newspaper,
              size: 40,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: onTapCategory,
          ),
          const Divider(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text('Hot news'),
            onTap: onTapHotNews,
          ),
          const Divider(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text('Breaking news'),
            onTap: onTapBreakingNews,
          )
        ],
      ),
    );
  }
}
