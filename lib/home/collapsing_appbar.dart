
import 'package:flutter/material.dart';
class CollapsingAppbarPage extends StatefulWidget {
  const CollapsingAppbarPage({Key? key}) : super(key: key);

  @override
  State<CollapsingAppbarPage> createState() => _CollapsingAppbarPageState();
}

class _CollapsingAppbarPageState extends State<CollapsingAppbarPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: NestedScrollView(
        //controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xCCE7E7EF),
              elevation: 1,
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Text("My Cube",
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Dancing Script',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      )),
                  background: Image(
                    image: AssetImage("assets/images/cubepinkish.png"),
                  )),
            ),
          ];
        },
        body: ListView(
            children: [Center(
                child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/family');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(26.0),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xfffce4ec),
                            Color(0xfff8bbd0),
                            Color(0xffa3bef8),
                            Color(0xff99b0fc),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 0.2, 0.5, 0.8]),
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              width: 120,
                              child: Image(
                                image: AssetImage("assets/images/familyblack.png"),
                              ),
                            ),
                          ),
                          const Text(
                            "Family",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/friends');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(26.0),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xfffce4ec),
                            Color(0xfff8bbd0),
                            Color(0xffa3bef8),
                            Color(0xff99b0fc)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 0.2, 0.5, 0.8]),
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              width: 120,
                              child: Image(
                                image: AssetImage("assets/images/friendsblack.png"),
                              ),
                            ),
                          ),
                          const Text(
                            "Friends",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/pets');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(26.0),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xfffce4ec),
                            Color(0xfff8bbd0),
                            Color(0xffa3bef8),
                            Color(0xff99b0fc)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 0.2, 0.5, 0.8]),
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              width: 120,
                              child: Image(
                                image: AssetImage("assets/images/dogdark.png"),
                              ),
                            ),
                          ),
                          const Text(
                            "Pets",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
          ]),
      ),
    );
  }
}
