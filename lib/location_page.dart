// import 'package:abdo/commercial_page.dart';
import 'dart:io';

import 'package:abdo/commercial_page.dart';
import 'package:abdo/home_page.dart';
import 'package:abdo/models/properties.dart';
import 'package:abdo/product.dart';
// import 'package:abdo/product.dart';
import 'package:abdo/resdintiall_page.dart';
import 'package:abdo/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

class LOcationPage extends StatefulWidget {
  final bool isResd;
  const LOcationPage({super.key, required this.isResd});

  @override
  State<LOcationPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LOcationPage> {
  getpermission() async {
    LocationPermission premission;
    premission = await Geolocator.requestPermission();
    if (premission == LocationPermission.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please open the Location'),
            actions: [
              TextButton(
                onPressed: () async {
                  premission = await Geolocator.requestPermission();
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              ),
              TextButton(
                onPressed: () {
                  Geolocator.openLocationSettings();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  // Future<void> getcurrentlocation() async {
  //   isloading = true;
  //   setState(() {});
  //   currentposition = await Geolocator.getCurrentPosition().then((value) {
  //     markers.add(
  //       Marker(
  //         markerId: const MarkerId('1'),
  //         position: loc = LatLng(value.latitude, value.longitude),
  //       ),
  //     );
  //     latitude = loc!.latitude;
  //     longitude = loc!.longitude;
  //     return null;
  //   });

  //   isloading = false;
  //   setState(() {});
  // }

/////////////////////////////////////////////end of methods ///////////////
  List<Marker> markers = [];
  LatLng? loc;
  Future<Position>? currentposition;
  double? latitude;
  double? longitude;
  late File imgUrl;
  bool isUploded = false;
  GoogleMapController? controllerMap;
  CameraPosition currentCamera =
      const CameraPosition(target: LatLng(27.181935, 31.186007), zoom: 15);
  bool isloading = false;
  final ApiServices apiServices = ApiServices();

  @override
  void initState() {
    getpermission();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          // backgroundColor: Colors.orangeAccent,
          ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Container(
                      padding: const EdgeInsets.all(35),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.black12,
                      ),
                      child: Column(
                        children: [
                          MaterialButton(
                            color: Colors.green,
                            onPressed: () async {
                              print('pressed');
                              print('pressed');
                              imgUrl = await Images().getImageUrl() ??
                                  File("nopath");
                              // FutureBuilder<File>(
                              //   future: Images().getImageUrl(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       return const CircularProgressIndicator(); // Show loading indicator while waiting for the image
                              //     } else if (snapshot.hasError) {
                              //       return const Text(
                              //         'Error loading image',
                              //       ); // Show an error message if image loading fails
                              //     } else {
                              //       imgUrl = snapshot.data ?? File('path');
                              //       isUploded = imgUrl != null;
                              //       return Container(
                              //         margin: const EdgeInsets.only(bottom: 15),
                              //         height: 130,
                              //         width: 250,
                              //         decoration: BoxDecoration(
                              //           image: DecorationImage(
                              //             image: NetworkImage('$imgUrl'),
                              //           ),
                              //         ),
                              //       );
                              //     }
                              //   },
                              // );
                            },
                          ),
                          const SizedBox(
                            height: 23,
                          ),

                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.black12,
                              ),
                              child: const Text(
                                "Upload Photo",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GoogleMap(
                            onTap: (LatLng latlang) {
                              markers.add(
                                Marker(
                                  markerId: const MarkerId("1"),
                                  position: loc = LatLng(
                                    latlang.latitude,
                                    latlang.longitude,
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                            markers: markers.toSet(),
                            initialCameraPosition: currentCamera,
                            onMapCreated: (GoogleMapController hello) {
                              controllerMap = hello;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // getcurrentlocation();
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 50),
                        Text(
                          'Choose the location',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final Property property;
                      try {
                        if (widget.isResd) {
                          property = Property(
                            type: typeR,
                            status: Statusss,
                            propertyaddress: propertyRAdressController.text,
                            price: int.parse(priceRController.text),
                            phoneNmber: int.parse(phoneRController.text),
                            moreDetails: detailsRController.text,
                            rentDuration: rentRduration,
                            latitude: latitude,
                            longitude: longitude,
                          );

                          final addedProperty = await apiServices
                              .addNewResdential(property, imgUrl);
                        } else {
                          property = Property(
                            type: typeC,
                            status: statusC,
                            propertyaddress: propertyCAdressController.text,
                            price: int.parse(priceCController.text),
                            phoneNmber: int.parse(phoneCController.text),
                            moreDetails: detailsCController.text,
                            rentDuration: rentDurationC,
                            latitude: latitude,
                            longitude: longitude,
                          );
                        }
                        final addedProperty =
                            await apiServices.addNewCommercial(property);

                        // Call the API to add the new property
                        if (addedProperty != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Data Added Successfully'),
                            ),
                          );
                        } else {
                          // Handle the case where the property wasn't added successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                  'Failed to add property. Please try again.'),
                            ),
                          );
                        }
                      } catch (e) {
                        print('Error adding data to Firestore: $e');
                        // Handle the error (e.g., show an error message)
                      }
                    },
                    child: const Text("Add Property"),
                  ),
                ],
              ),
            ),
    );
  }
}
