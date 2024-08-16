
import 'package:flutter/material.dart';
import '../../services/shared_preference_service.dart';
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.red),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
              NetworkImage("ggg"),
            ),
            accountName: Text("",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text("ayus",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(
              Icons.edit,
            ),
            title: const Text('Edit Profile'),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
            ),
            title: const Text('Logout'),
            onTap: () async {
              await SharedPreferenceService.setUserLogin("IsLogin", false);
              Navigator.pushReplacementNamed(context, "login-page");
            },
          ),
          // Obx(() {
          //   List<String> categories =
          //   productsController.getProductsCategories();
          //   String? category;
          //   String cat = productsController.Category.value;
          //   if (!cat.isEmpty) {
          //     category = cat;
          //   }
          //
          //   return Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     child: DropdownButton(
          //         value: category,
          //         elevation: 0,
          //         hint: Row(children: [
          //           Icon(
          //             Icons.category,
          //           ),
          //           HorizontalSpacing(size: 10),
          //           Text("Categories")
          //         ]),
          //         items: categories.map((e) {
          //           return DropdownMenuItem(
          //               value: e,
          //               child: Row(
          //                 children: [
          //                   Icon(
          //                     Icons.arrow_forward,
          //                   ),
          //                   Text(e)
          //                 ],
          //               ));
          //         }).toList(),
          //         onChanged: (value) {
          //           productsController.Category.value = value.toString();
          //           Get.to(SingleCategoryPage(
          //             category: value.toString(),
          //           ));
          //         }),
          //   );
          // }),
          //
          // // }),
          AboutListTile(
            // <-- SEE HERE
            icon: Icon(
              Icons.info,
            ),
            child: Text('About app'),
            applicationIcon: Icon(
              Icons.local_play,
            ),
            applicationName: 'My Cool App',
            applicationVersion: '1.0.25',
            applicationLegalese: '© 2019 Company',
          ),
        ],
      ),
    );
  }
}
