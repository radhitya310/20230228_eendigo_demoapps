import 'package:eendigodemo/liveness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Map> menuFavorites = [
    {
      'label': 'Liveness',
      'icon': CupertinoIcons.person,
      'screen': const Liveness(),
      'color': Colors.green
    },
    {
      'label': 'FaceCompare',
      'icon': CupertinoIcons.person_2,
      'screen': const Liveness(),
      'color': Colors.green
    }
  ];

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
                            SizedBox(width: 16,),
                            Text('Find services, food, or place',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16,),
                Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () { },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(Icons.person,
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
                runSpacing: 8,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  for (final menuFavorite in menuFavorites) Material(
                      borderRadius: BorderRadius.circular(16),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: menuFavorite['color'].withOpacity(0.4),
                        highlightColor: menuFavorite['color'].withOpacity(0.2),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => menuFavorite['screen']));},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: menuFavorite['color'].withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      child: Icon(menuFavorite['icon'],
                                        size: 50
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(menuFavorite['label'])
                            ],
                          ),
                        ),
                      )
                  ),
                  Material(
                      borderRadius: BorderRadius.circular(16),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.more_horiz)
                              ),
                              const SizedBox(height: 8,),
                              const Text('More to come!')
                            ],
                          ),
                        ),
                      )
                  )
                ]
            ),
          ],
        ),
      ),
    );
  }
}
