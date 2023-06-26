import 'package:flutter/material.dart';

class CollapsingAppbarPage extends StatelessWidget {
  const CollapsingAppbarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 1,
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Text("My Cube",
                      style:  TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Dancing Script',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  background: Image(
                    image: AssetImage("assets/images/cubepinkish.png"),
                  )
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                children: [
                  Container(
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
                    child: TextButton(
                      child: const Text(
                        "Family",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/family');
                      },
                    ),
                  ),
                  Container(
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/friends');
                      },
                      child: const Text(
                        "Friends",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/pets');
                      },
                      child: const Text(
                        "Pets",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}