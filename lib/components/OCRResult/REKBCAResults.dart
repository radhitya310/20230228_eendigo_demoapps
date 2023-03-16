import 'package:eendigodemo/components/CopyDataComponent/CopyDataKTP.dart';
import 'package:eendigodemo/model/REKBCAModel.dart';
import 'package:flutter/material.dart';

class REKBCAOCRResults extends StatelessWidget {
  final List<Rekbcaocr> data;
  const REKBCAOCRResults({required this.data});

  // final List<Widget> data1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(32),
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: const [
                            Icon(Icons.search),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Find services, food, or place',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          // Text('date : ' + data[0].ocrDate),
          Text('message : ' + data[0].message),
          Text('status : ' + data[0].status),
          Text('Nama : ' + data[0].read.identity.accountNumber),
          Text('Nama : ' + data[0].read.identity.bankOffice),
          Text('Nama : ' + data[0].read.identity.name)
        ],
      )),
    );
  }
}
