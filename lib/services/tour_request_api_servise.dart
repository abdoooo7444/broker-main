import 'package:abdo/models/tour_req_model.dart';
import 'package:dio/dio.dart';

class tourApiServices {
  late final Dio dio;

  tourApiServices() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.1.8:4000",
      ),
    );
  }
  Future<TourRequest?> addNewTour(TourRequest request) async {
    try {
      final Response<Map<String, dynamic>> response =
          await dio.post('/api/tours', data: request.toJson());

      if (response.data != null) {
        return TourRequest.fromJson(response.data!);
      } else {
        throw Exception('Failed to create new tour request');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      print('Error adding new tour request: ${e.type}, ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<TourRequest?> updateTour(
      String tourId, TourRequest updatedRequest) async {
    try {
      final Response<Map<String, dynamic>> response =
          await dio.put('/api/tours/$tourId', data: updatedRequest.toJson());

      if (response.data != null) {
        return TourRequest.fromJson(response.data!);
      } else {
        throw Exception('Failed to update tour request');
      }
    } on DioError catch (e) {
      print('Error updating tour request: ${e.type}, ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  Future<List<TourRequest>> getTourRequests() async {
    try {
      final Response<List<dynamic>> response = await dio.get('/api/tours');

      List<TourRequest> tour = [];

      if (response.data != null) {
        tour = response.data!
            .map((e) => TourRequest.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return tour;
    } catch (e) {
      print('Error retrieving residential data: $e');
      rethrow;
    }
  }
}
