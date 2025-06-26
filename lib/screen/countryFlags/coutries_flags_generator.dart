import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/config.dart';
import 'package:barcontent/util/constants.dart';
import 'package:barcontent/util/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CountriesFlagGenerator extends StatefulWidget {
  const CountriesFlagGenerator({super.key});

  @override
  State<CountriesFlagGenerator> createState() => _CountriesFlagGeneratorState();
}

class _CountriesFlagGeneratorState extends State<CountriesFlagGenerator> {
  List<List<String>> csvCountries = [];
  List<String> allFlags = [];
  Future<void> pickAndReadCsv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      Uint8List fileBytes = result.files.single.bytes!;
      String csvString = utf8.decode(fileBytes);
      List<List<dynamic>> data = const CsvToListConverter().convert(csvString);

      if (data.isNotEmpty) {
        List<String> headers = data.first.map((e) => e.toString()).toList();
        List<Map<String, dynamic>> dataAsMap = [];
        for (int i = 1; i < data.length; i++) {
          Map<String, dynamic> row = {};
          for (int j = 0; j < headers.length; j++) {
            if (headers[j] == 'country') {
              row[headers[j]] = data[i][j];
            }
          }

          dataAsMap.add(row);
        }

        csvCountries = [];
        allFlags = [];

        for (var country in dataAsMap) {
          if (country['country'].toString().isNotEmpty) {
            final selectedCountry = allCountries
                .where((ctry) => ctry['name']
                    .toString()
                    .toLowerCase()
                    .contains(country['country'].toString().toLowerCase()))
                .toList();
            if (selectedCountry.isNotEmpty) {
              allFlags.add(
                  'https://videocreator.codepie.com.pk/svg/${selectedCountry.first['code'].toString().toLowerCase()}.svg');
              csvCountries.add([
                'country',
                'https://videocreator.codepie.com.pk/svg/${selectedCountry.first['code'].toString().toLowerCase()}.svg',
              ]);
            } else {
              csvCountries.add([
                'country',
                '----------------Not Found----------------',
              ]);
            }
          }
        }
      }
    }
    print(allFlags);
    setState(() {});
  }

  Future<void> generateCountriesFlags() async {
    saveCsvAsFile(csvCountries);
  }

  void saveCsvAsFile(List<List<String>> data) {
    // Convert the 2D data (List<List<String>>) to a CSV string
    StringBuffer csvData = StringBuffer();

    for (var row in data) {
      csvData.writeln(row.join(','));
    }

    // Create a Blob from the CSV data
    final blob = html.Blob([csvData.toString()]);

    // Create a URL for the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create an anchor element with download attributes
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'data.csv'; // Set the file name (e.g., 'data.csv')

    // Trigger the download
    anchor.click();

    // Clean up the created URL
    html.Url.revokeObjectUrl(url);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  pickAndReadCsv();
                },
                child: Container(
                  padding: spacing(h: 30, v: 8),
                  decoration: BoxDecoration(
                    color: darkBlue,
                    borderRadius: borderRadius(10),
                  ),
                  child: Text(
                    'Import',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              gap(h: 15),
              Text(
                'All Countries: ${csvCountries.length.toString()}',
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: halfBlack,
                ),
              ),
              gap(w: 30),
              Container(
                width: Get.width * 0.5,
                child: allFlags.isEmpty
                    ? gap()
                    : Column(
                        children: [
                          Wrap(
                            children: allFlags.map((flg) {
                              return ClipRRect(
                                borderRadius: borderRadius(15),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: spacing(h: 3, v: 5),
                                  child: CachedNetworkImage(
                                    imageUrl: flg,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          gap(h: 30),
                          InkWell(
                            onTap: () {
                              generateCountriesFlags();
                            },
                            child: Container(
                              padding: spacing(h: 30, v: 8),
                              decoration: BoxDecoration(
                                color: darkBlue,
                                borderRadius: borderRadius(10),
                              ),
                              child: Text(
                                'Generate Countries Flags',
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
