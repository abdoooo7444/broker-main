import 'package:abdo/home_page.dart';
// ignore: unused_import
import 'package:abdo/models/offers_model.dart';
// import 'package:abdo/models/offers_model.dart';
import 'package:abdo/services/offer_api.dart';
import 'package:flutter/material.dart';

class ShowOffers extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ShowOffers> {
  bool isloading = true;

  int currentIndex = 0; // Add a default value
  List<Offers> Offer = [];

  Future<void> getoffer() async {
    try {
      print("===========================================");
      setState(() {
        isloading = true;
      });
      final data = await OfferApiServices().getOffer();
      Offer = data;
      setState(() {
        isloading = false;
      });
    } catch (e) {
      print("===========================================");
      print(e);
      print("===========================================");
    }
  }

  @override
  void initState() {
    getoffer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Color.fromRGBO(118, 165, 209, 1),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: Offer.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => SingleProperty(
                          //         data: CCommercial[index],
                          //       ),
                          //     ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                width: double.infinity,
                                color: Colors.grey[200],
                                // child: Image.network(
                                //   '${Offers[Offer].}',
                                //   height: 200,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  height: 180,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            '${Offer[index].propertyaddress}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ' Name : ${Offer[index].username}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'Gmail : ${Offer[index].email}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          ' Newnumber : ${Offer[index].phoneNumber}     Oldnumber ${Offer[index].phoneNumber} ',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          'Details : ${Offer[index].moreDetails}',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "property price : ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              ' ${Offer[index].price} \$',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                  255,
                                                  13,
                                                  71,
                                                  119,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Offer price : ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              ' ${Offer[index].rentDuration} \$',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                  255,
                                                  13,
                                                  71,
                                                  119,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
