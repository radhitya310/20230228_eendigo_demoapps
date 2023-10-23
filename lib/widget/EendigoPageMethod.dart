// ignore_for_file: non_constant_identifier_names

import 'package:eendigodemo/components/master/imagePathMaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration EendigoLogoHeader() {
    return const BoxDecoration(
        image: DecorationImage(
      image: AssetImage("Assets/img/background-eendigo_(1).png"),
      fit: BoxFit.cover,
    ));
  }

PreferredSize EendigoLogo(BuildContext context){
  return PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(6),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Navigator.of(context).canPop() == false ? Container() :
                    TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(CupertinoIcons.arrow_left)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8,10.0,8,0),
                        child: Image.asset(ImagePath.eendigoLogo,
                            fit: BoxFit.contain),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
}