import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              padding:
                  EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xffD897FD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.dashboard,
                        size: 30,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.logout,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 10),
                    child: Text("- This is Dashboard Page -",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                        decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Here..",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    )),
                  ),
                  // Row(
                  //   SizedBox(height: 10),
                  //   GridView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       childAspectRatio:
                  //           (MediaQuery.of(context).size.height - 50 - 25) /
                  //               (4 * 240),
                  //       mainAxisSpacing: 10,
                  //       crossAxisSpacing: 10,
                  //     ),
                  //     itemBuilder: (context, index) {
                  //       return InkWell(
                  //         onTap: () {},
                  //         child: Container(
                  //           padding: EdgeInsets.symmetric(
                  //               vertical: 20, horizontal: 10),
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20),
                  //             color: Colors.grey,
                  //           ),
                  //           child: Column(
                  //             children: [],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 32,
        selectedItemColor: Color(0xffD897FD),
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
