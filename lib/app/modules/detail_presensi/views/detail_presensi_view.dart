import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/detail_presensi_controller.dart';

class DetailPresensiView extends GetView<DetailPresensiController> {
  const DetailPresensiView({Key? key}) : super(key: key);
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
                      "${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
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
                    "Time : ${DateFormat.jms().format(DateTime.now())}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Location : -6.123.123.123",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Status : Coverage Area",
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
                    "Time : ${DateFormat.jms().format(DateTime.now())}",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Location : -6.123.123.123",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black)),
                  ),
                  Text(
                    "Status : Coverage Area",
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
