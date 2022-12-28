import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  final Map<String, dynamic> data = Get.arguments;
  DetailPresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Presensi'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      DateFormat.yMMMMEEEEd()
                          .format(DateTime.parse(data['date'])),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Start Day",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                  Text(
                    "Time : ${DateFormat.jms().format(DateTime.parse(data['start_day']!['date']))}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Location : ${data['start_day']!['lat']}, ${data['start_day']!['long']}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Distance : ${data['start_day']!['distance'].toString().split(".").first} M",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Address : ${data['start_day']!['address']}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Status : ${data['start_day']!['status']}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "End Day",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black)),
                  ),
                  Text(
                    data['end_day']?['date'] == null
                        ? "Time : -"
                        : "Time : ${DateFormat.jms().format(DateTime.parse(data['end_day']!['date']))}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    data['end_day']?['lat'] == null &&
                            data['end_day']?['long'] == null
                        ? "Location : -"
                        : "Location : ${data['end_day']!['lat']}, ${data['end_day']!['long']}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    data['end_day']?['distance'] == null
                        ? "Distance : -"
                        : "Distance : ${data['end_day']!['distance'].toString().split(".").first} M",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    data['end_day']?['address'] == null
                        ? "Address : -"
                        : "Address : ${data['end_day']!['address']}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    data['end_day']?['status'] == null
                        ? "Status : -"
                        : "Status : ${data['end_day']!['status']}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
