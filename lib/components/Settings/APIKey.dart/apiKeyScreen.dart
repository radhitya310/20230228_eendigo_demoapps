import 'package:eendigodemo/model/APIKeyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyScreen extends StatefulWidget {
  const ApiKeyScreen({Key? key}) : super(key: key);

  @override
  State<ApiKeyScreen> createState() => _ApiKeyScreenState();
}

class _ApiKeyScreenState extends State<ApiKeyScreen> {
  String _selectedProduct = '';
  APIKeyModel apiKey = APIKeyModel(tenantCode: '', key: '');
  late SharedPreferences prefs;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    initializeSetting();
    super.initState();
  }

  void initializeSetting() async {
    prefs = await SharedPreferences.getInstance();
    String? tenantCode = prefs.getString('tenantCode') ?? '';
    String? key = prefs.getString('key') ?? '';
    setState(() {
      apiKey.tenantCode = tenantCode;
      apiKey.key = key;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Column(
        children: const [
          Center(
            child: CircularProgressIndicator(),
          ),
          Center(
            child: Text('This may take a while'),
          ),
        ],
      );
    }else{
      return Scaffold(
      appBar: AppBar(
        title: const Text('API Key'),
        actions: [
          TextButton(
            onPressed: () {
              prefs.setString('tenantCode', apiKey.tenantCode);
                prefs.setString('key', apiKey.key);
              setState(() {
                isLoading = true;
                Navigator.of(context).pop();
                isLoading = false;
              });
                
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: <CustomSettingsTile>[
              CustomSettingsTile(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextFormField(
                    initialValue: apiKey.tenantCode,
                    decoration: const InputDecoration(
                        hintText: 'Enter Tenant Code',
                        contentPadding: EdgeInsets.only(left: 16),
                        labelText: 'Tenant Code',
                        helperText: 'Input the Tenant Code provided by AdIns.'),
                    onChanged: (value) {
                      setState(() {
                        apiKey.tenantCode = value;
                      });
                    },
                  ),
                ),
              ),
              CustomSettingsTile(
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: TextFormField(
                    initialValue: apiKey.key,
                    decoration: const InputDecoration(
                        hintText: 'Enter API Key',
                        contentPadding: EdgeInsets.only(left: 16),
                        labelText: 'API Key',
                        helperText: 'Input the API Key provided by AdIns.'),
                    onChanged: (value) {
                      setState(() {apiKey.key = value;});
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    }
    
  }
}
