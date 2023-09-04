// ignore_for_file: non_constant_identifier_names

import 'package:eendigodemo/components/master/imagePathMaster.dart';
import 'package:flutter/cupertino.dart';

BoxDecoration EendigoLogoHeader() {
    return const BoxDecoration(
        image: DecorationImage(
      image: AssetImage("Assets/img/background-eendigo_(1).png"),
      fit: BoxFit.cover,
    ));
  }

PreferredSize EendigoLogo(){
  return PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.eendigoLogo,
                        fit: BoxFit.contain),
                  ],
                ),
              ),
            ),
          );
}