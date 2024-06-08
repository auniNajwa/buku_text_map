import 'package:bukutextly_admins/main.dart';
import 'package:bukutextly_admins/pages/reports_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  int totalProducts = 0;

  @override
  void initState() {
    super.initState();
    fetchTotalProducts();
  }

  Future<void> fetchTotalProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      setState(() {
        totalProducts = querySnapshot.docs.length;
      });
    } catch (e) {
      print('Error fetching total products: $e');
    }
  }

  Future<String> fetchAdminUsername() async {
    // Replace with your Firestore collection and document ID
    DocumentSnapshot adminDoc = await FirebaseFirestore.instance
        .collection('Admins')
        .doc(currentUser.email)
        .get();

    if (adminDoc.exists) {
      return adminDoc['username'];
    } else {
      throw Exception('Admin not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String adminUsername = 'admin'; // Example admin username
    // final String currentDate = DateTime.now().toString(); // Current date

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 420,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFF885A3A),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      'DASHBOARD',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC9B09A),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'TOTAL SALES',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'RM 00',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBD0BD),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 1,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'TOTAL PRODUCT',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '$totalProducts',
                            style: const TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 420,
                height: 350,
                decoration: BoxDecoration(
                  color: const Color(0xFFA77D54),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          'SALES CHART',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 390,
                      height: 280,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                const FlSpot(0, 0),
                                const FlSpot(1, 3),
                                const FlSpot(2, 10),
                                const FlSpot(3, 7),
                                const FlSpot(4, 2),
                                const FlSpot(5, 9),
                                const FlSpot(6, 10),
                              ],
                              isCurved: true,
                              color: Colors.white,
                              barWidth: 2,
                              belowBarData: BarAreaData(
                                show: true,
                                color: const Color(0xFFC9B09A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/userslistpage');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA77D54),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 3,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        minimumSize: const Size(250, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: const Text('USERLIST'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                      child: Icon(
                        Icons.group,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Navigator.pushNamed(
                        //   context,
                        //   '/reports',
                        //   arguments: ReportsPageArguments(
                        //     adminUsername: adminUsername,
                        //     date: currentDate,
                        //     totalListings: totalProducts,
                        //   ),
                        // ); //UBAH SINI

                        try {
                          String adminUsername = await fetchAdminUsername();
                          String currentDate = DateFormat('yyyy-MM-dd HH:mm')
                              .format(DateTime.now());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportsPage(
                                adminUsername: adminUsername,
                                date: currentDate,
                                totalListings: totalProducts,
                              ),
                            ),
                          );
                        } catch (e) {
                          // Handle errors (e.g., show a snackbar or dialog)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Error fetching admin username: $e'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA77D54),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontFamily: 'Readex Pro',
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 3,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        minimumSize: const Size(250, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: const Text('REPORT'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                      child: Icon(
                        Icons.add_chart,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
