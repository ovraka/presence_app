import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/more_presensi_controller.dart';

class MorePresensiView extends GetView<MorePresensiController> {
  const MorePresensiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Presensi'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_PRESENSI);
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Start Day",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                          Text(
                            "${DateFormat.yMMMEd().format(DateTime.now())}",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                      Text(
                        "${DateFormat.jms().format(DateTime.now())}",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 10,
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
                        "${DateFormat.jms().format(DateTime.now())}",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
