import 'dart:convert';
import 'package:eendigodemo/components/Settings/APIKey.dart/apiKeyScreen.dart';
import 'package:eendigodemo/model/APIKeyModel.dart';
import 'package:eendigodemo/model/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _selectedProduct = '';
  late APIKeyModel apiKey;
  @override
  void initState() {
    initializeSetting();
    super.initState();
  }

  Future<String?> getValueFromStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  void initializeSetting() async {
    Future<String?> tenantCode = getValueFromStorage('tenantCode');
    Future<String?> key = getValueFromStorage('key');
    apiKey.tenantCode = tenantCode as String;
    apiKey.key = key as String;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("Assets/img/background-eendigo_(1).png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text("Setting")),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text('General'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.key),
                  title: Text('API Key'),
                  onPressed: (context) => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApiKeyScreen()),
                    )
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector settingOption(
      BuildContext context, String title, Widget navigatePage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigatePage),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:eendigodemo/components/Settings/APIKey.dart/apiKeyScreen.dart';
// import 'package:eendigodemo/model/APIKeyModel.dart';
// import 'package:eendigodemo/model/ProductModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart' show rootBundle;

// class SettingScreen extends StatefulWidget {
//   const SettingScreen({Key? key}) : super(key: key);

//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }

// class _SettingScreenState extends State<SettingScreen> {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   String _selectedProduct = '';
//   late APIKeyModel apiKey;
//   @override
//   void initState() {
//     initializeSetting();
//     super.initState();
//   }


// Future<String?> getValueFromStorage(String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString(key);
// }
//   void initializeSetting() async {
//     Future<String?> tenantCode = getValueFromStorage('tenantCode');
//     Future<String?> key = getValueFromStorage('key');
//     apiKey.tenantCode = tenantCode as String;
//     apiKey.key = key as String;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("Assets/img/background-eendigo_(1).png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(title: const Text("Setting")),
//         body: ListView(
//           children: <Widget>[
//             // ...
//             const SizedBox(
//               height: 16.0,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     'General',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25.0,
//                     ),
//                   ),
//                 ),
//                 Divider(height: 20, thickness: 1,),
//                 settingOption(context, 'API Key', const ApiKeyScreen()),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TextFormField(
//                     //initialValue: _name,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter API Key',
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         //_name = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   GestureDetector settingOption(BuildContext context, String title, Widget navigatePage){
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => navigatePage),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(title, style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//               color: Colors.black
//             ),),
//             Icon(Icons.arrow_forward_ios, color: Colors.black,)
//           ],
//         ),
//       ),
//     );
//   }
// }