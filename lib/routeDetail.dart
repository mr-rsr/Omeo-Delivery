import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omeo_delivery/OrderDetail.dart';
import 'package:omeo_delivery/locationProvider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteDetail extends StatefulWidget {
  RouteDetail({super.key, required this.orders, required this.index});
  final List<OrderDetail> orders;
  final int index;
  @override
  State<RouteDetail> createState() => _RouteDetailState();
}

class _RouteDetailState extends State<RouteDetail> {
  bool submitted1 = false;
  bool submitted2 = false;
  bool delivered = false;
  String address = '';
  double latitude = 0;
  double longitude = 0;
  @override
  void initState() {
    super.initState();
  }

  Color color = const Color(0xff188F79);
  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    int index = widget.index;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color(0xff188F79),
          title: Text(
            "Drop Address",
            style: GoogleFonts.inter(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // widget.orders[index].associatedOrderId,
                          widget.orders[index].associatedOrderId.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            const ImageIcon(
                              AssetImage("assets/images/location.png"),
                              color: Colors.green,
                              size: 15,
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      locationProvider.getaddress,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                            height: 20,
                            width: 20,
                            image: AssetImage('assets/images/chronometer.png')),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '18:20:15',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffFD683D),
                              ),
                              child: Center(
                                child: Text(
                                  "P1",
                                  style: GoogleFonts.inter(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => launchMap(widget.orders[index]
                                  .ordersList[0].order.address.address),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 125,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            widget.orders[index].ordersList[0]
                                                .order.address.address,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formatDate(widget.orders[index]
                                        .ordersList[0].order.timeStamp),
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),
                            button(
                                "Pickup",
                                submitted1
                                    ? null
                                    : () {
                                        setState(() {
                                          submitted1 = true;
                                          color = const Color(0xff919EAB)
                                              .withOpacity(0.5);
                                          widget.orders[index].ordersList[1]
                                              .order.orderStatusCode = 4;
                                        });
                                      }),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: FDottedLine(
                              color: Colors.grey,
                              width: 1,
                              height: 100,
                              dottedLength: 5,
                              space: 2,
                            ),
                          ),
                        ),
                        widget.orders[index].ordersList.length == 2
                            ? Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFD683D),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "P2",
                                        style: GoogleFonts.inter(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () => launchMap(widget.orders[index]
                                        .ordersList[1].order.address.address),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 125,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  widget
                                                      .orders[index]
                                                      .ordersList[1]
                                                      .order
                                                      .address
                                                      .address,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: GoogleFonts.inter(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          formatDate(widget.orders[index]
                                              .ordersList[1].order.timeStamp),
                                          style: GoogleFonts.inter(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 50),
                                  button(
                                      "Pickup",
                                      submitted2
                                          ? null
                                          : () {
                                              setState(() {
                                                submitted2 = true;
                                                color = const Color(0xff919EAB)
                                                    .withOpacity(0.5);
                                                widget
                                                    .orders[index]
                                                    .ordersList[1]
                                                    .order
                                                    .orderStatusCode = 4;
                                              });
                                            }),
                                ],
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: FDottedLine(
                              color: Colors.grey,
                              width: 1,
                              height: 100,
                              dottedLength: 5,
                              space: 2,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffFD683D),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.person_2_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  launchMap(locationProvider.userAddress),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 125,
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            locationProvider.userAddress,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formatDate(widget.orders[index].timeStamp),
                                    style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 50),
                            button(
                                "Delivered",
                                delivered
                                    ? null
                                    : () {
                                        setState(() {
                                          delivered = true;
                                          color = const Color(0xff919EAB)
                                              .withOpacity(0.5);
                                          widget.orders[index].ordersList[1]
                                              .order.orderStatusCode = 5;
                                          if (widget.orders[index].ordersList
                                                  .length ==
                                              2) {
                                            widget.orders[index].ordersList[1]
                                                .order.orderStatusCode = 5;
                                          }
                                        });
                                      }),
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget button(String title, void Function()? pressed) {
    return SizedBox(
      width: 90,
      height: 35,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.all(0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: pressed,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  String formatDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDate = DateFormat('dd MMM yyyy hh:mma').format(dateTime);
    return formattedDate;
  }

  void launchMap(String destination) async {
    final url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$destination');
    //string to url
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
