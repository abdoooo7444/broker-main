import 'package:abdo/models/offers_model.dart';
import 'package:dio/dio.dart';

class OfferApiServices {
  late final Dio dio;

  OfferApiServices() : super() {
    // Call super constructor
    dio = Dio(
      BaseOptions(
        baseUrl: "http://10.0.2.2:4000",
      ),
    );
  }

  Future<List<Offers>> getOffer() async {
    try {
      final Response<List<dynamic>> response = await dio.get('/api/offers');

      List<Offers> Offfer = [];

      if (response.data != null) {
        Offfer = response.data!
            .map((e) => Offers.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return Offfer;
    } catch (e) {
      print('Error retrieving residential data: $e');
      rethrow;
    }
  }
}
