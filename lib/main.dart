import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omeo_delivery/OrderDetail.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:omeo_delivery/locationProvider.dart';
import 'package:omeo_delivery/routeDetail.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
//firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LocationProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Omeo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future _myFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myFuture =
        FirebaseFirestore.instance.collection('OrdersToBeDelivered').get();
    getLocation();
  }

  Future<String?> getLocation() async {
    String? add = await Provider.of<LocationProvider>(context, listen: false)
        .getAddressFromLatLng();

    return add;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff188F79),
          title: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                'Omeo',
                style: GoogleFonts.pacifico(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Delivery',
                style: GoogleFonts.pacifico(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        body: SizedBox.expand(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('OrdersToBeDelivered')
                .snapshots(),
            builder: (ctx, stream) {
              if (stream.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                QuerySnapshot? querySnapshot = stream.data;
                List<OrderDetail> orders = [];
                for (var element in querySnapshot!.docs) {
                  orders.add(OrderDetail.fromJson(
                      element.data() as Map<String, dynamic>));
                }

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: orders.length,
                  itemBuilder: (ctx, index) {
                    String location = orders[index].userAddress;
                    List<String> parts = location.split(',');
                    double latitude = double.parse(parts[0]);
                    double longitude = double.parse(parts[1]);

                    getAdd(latitude, longitude);
                    int totalItems = orders[index].ordersList.length;
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => RouteDetail(
                            orders: orders,
                            index: index,
                          ),
                        ),
                      ),
                      child: Container(
                        width: 310,
                        height: 180,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 0.0,
                                  blurRadius: 2,
                                  offset: Offset(0, 0)),
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  orders[index].associatedOrderId,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Image(
                                        height: 20,
                                        width: 20,
                                        image: AssetImage(
                                            'assets/images/chronometer.png')),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '18:20:15',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Image(
                                          height: 22,
                                          width: 22,
                                          image: AssetImage(
                                              'assets/images/deliverybike.png')),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 22,
                                        width: 22,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff1892FA)
                                                .withOpacity(0.17),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            totalItems.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Image(
                                        height: 22,
                                        width: 22,
                                        image: AssetImage(
                                            'assets/images/location.png')),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    totalItems == 1
                                        ? Container(
                                            width: 25,
                                            height: 25,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffFD683D),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "P1",
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          )
                                        : twoPoint(),
                                  ],
                                ),
                                Row(
                                  textBaseline: TextBaseline.alphabetic,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage('assets/images/cash.png'),
                                      height: 22,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "₹${orders[index].totalOrderValue.toStringAsFixed(2)}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage('assets/images/turn.png'),
                                      height: 16,
                                      width: 12,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          estimatedDistance(
                                              orders[index].estimatedDistance),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text("est. Distance",
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.grey.shade400,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/estimatedDistance.png'),
                                      height: 22,
                                      width: 22,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      estimatedTime(
                                          orders[index].estimatedTime),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }

  Widget twoPoint() {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFD683D),
          ),
          child: Center(
            child: Text(
              "P1",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
        FDottedLine(
          color: Colors.grey,
          width: 20.0,
          strokeWidth: 1.5,
          dottedLength: 1.5,
          space: 1.0,
        ),
        Container(
          width: 25,
          height: 25,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFD683D),
          ),
          child: Center(
            child: Text(
              "P2",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }

  String estimatedDistance(double km) {
    double dis = km * 1000;
    if (dis < 1000) {
      return "${dis.toStringAsFixed(0)} m";
    } else {
      return "${(dis / 1000).toStringAsFixed(2)} km";
    }
  }

  String estimatedTime(double time) {
    if (time < 60) {
      return "${time.toStringAsFixed(2)} min";
    } else {
      return "${(time / 60).toStringAsFixed(2)} hr";
    }
  }

  getAdd(double lat, double long) async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    String? userAddress = await locationProvider.addressFromLatlng(lat, long);
    debugPrint(lat.toString());
  }
}
