import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:barcontent/util/colors.dart';
import 'package:barcontent/util/constants.dart';
import 'package:barcontent/util/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CountriesFlagGenerator extends StatefulWidget {
  const CountriesFlagGenerator({super.key});

  @override
  State<CountriesFlagGenerator> createState() => _CountriesFlagGeneratorState();
}

class _CountriesFlagGeneratorState extends State<CountriesFlagGenerator> {
  List<List<String>> csvCountries = [];
  List<String> allFlags = [];
  bool isLoading = false;

  Future<void> loadAndFormatCountries() async {
    // Option 1: From remote URL (your provided link)
    isLoading = true;
    setState(() {});
    print('---------------_Getting Flags_-----------------');
    final String response =
        await rootBundle.loadString('assets/flags/countries.json');
    final data = json.decode(response);

    List<dynamic> allCountriesList = data.entries
        .map((entry) =>
            {'name': entry.value.toString(), 'code': entry.key.toString()})
        .toList();

    // Optional: Sort alphabetically by name
    allCountriesList.sort((a, b) => a['name']!.compareTo(b['name']!));
    allCountries = allCountriesList;
    isLoading = false;
    setState(() {});
  }

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
        print(dataAsMap);
        for (var country in dataAsMap) {
          if (country['country'].toString().isNotEmpty) {
            List selectedCountry = allCountries
                .where((ctry) => ctry['name']
                    .toString()
                    .toLowerCase()
                    .trim()
                    .contains(
                        country['country'].toString().toLowerCase().trim()))
                .toList();
            if (selectedCountry.isEmpty) {
              selectedCountry = allCountries
                  .where((cty) => cty['code']
                      .toString()
                      .toLowerCase()
                      .trim()
                      .contains(
                          country['code'].toString().toLowerCase().trim()))
                  .toList();
            }
            print('-----------------------> ${selectedCountry}');
            if (selectedCountry.isNotEmpty) {
              allFlags.add(
                  '${domainUrl}assets/assets/flags/${selectedCountry.first['code'].toString().toLowerCase()}.svg');
              csvCountries.add([
                'country',
                '${domainUrl}assets/assets/flags/${selectedCountry.first['code'].toString().toLowerCase()}.svg',
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
    final blob = html.Blob([csvData.toString()]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'flags_data.csv'; // Set the file name (e.g., 'data.csv')

    // Trigger the download
    anchor.click();

    // Clean up the created URL
    html.Url.revokeObjectUrl(url);
  }

  @override
  void initState() {
    loadAndFormatCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: Get.width,
      height: Get.height,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: halfBlack,
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                        gap(h: 30),
                        csvCountries.isNotEmpty
                            ? InkWell(
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
                              )
                            : Center(
                                child: Text('No Flag Found'),
                              ),
                      ],
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
                          : Wrap(
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
                    ),
                  ],
                ),
              ],
            ),
    ));
  }
}
