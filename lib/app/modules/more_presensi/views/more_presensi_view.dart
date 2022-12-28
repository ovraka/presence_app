import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
      ),
      body: GetBuilder<MorePresensiController>(
        builder: (controller) => FutureBuilder<
                QuerySnapshot<Map<String, dynamic>>>(
            future: controller.historyPresence(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
                return Center(
                  child: Text(
                    "Tidak ada data presensi",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  Map<String, dynamic> data = snapshot.data!.docs[index].data();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_PRESENSI, arguments: data);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    DateFormat.yMMMEd()
                                        .format(DateTime.parse(data["date"])),
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                  ),
                                ],
                              ),
                              Text(
                                data["start_day"]?["date"] == null
                                    ? "-"
                                    : DateFormat.jms().format(DateTime.parse(
                                        data["start_day"]!["date"])),
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
                                data["end_day"]?["date"] == null
                                    ? "-"
                                    : DateFormat.jms().format(DateTime.parse(
                                        data["end_day"]!["date"])),
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
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(Dialog(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 400,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                selectionMode: DateRangePickerSelectionMode.range,
                showActionButtons: true,
                onCancel: () => Get.back(),
                onSubmit: (value) {
                  if (value != null) {
                    if ((value as PickerDateRange).endDate != null) {
                      controller.pickerDate(value.startDate!, value.endDate!);
                    }
                  }
                },
              ),
            ),
          ));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
