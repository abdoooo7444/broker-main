import 'dart:io';

import 'package:abdo/models/properties.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class ApiServices {
  late Dio dio;

  ApiServices() {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://10.0.2.2:4000",
      ),
    );
  }

  Future<List<Property>> getResidential() async {
    try {
      final Response<List<dynamic>> response =
          await dio.get('/api/properties/Res');

      List<Property> properties = [];

      if (response.data != null) {
        properties = response.data!
            .map((e) => Property.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return properties;
    } catch (e) {
      print('Error retrieving residential data: $e');
      rethrow;
    }
  }

  Future<List<Property>> getcommercials() async {
    try {
      final Response<List<dynamic>> response =
          await dio.get('/api/properties/Comm');

      List<Property> properties = [];

      if (response.data != null) {
        properties = response.data!
            .map((e) => Property.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return properties;
    } catch (e) {
      print('Error retrieving residential data: $e');
      rethrow;
    }
  }

  Future<Property?> addNewResdential(Property property, File imageFile) async {
    try {
      FormData formData = FormData.fromMap({
        ...property.toJson(),
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      });
      print(formData.fields);
      final Response<Map<String, dynamic>> response =
          await dio.post('/api/properties/Res', data: formData);

      if (response.data != null) {
        return Property.fromJson(response.data!);
      }

      return null;
    } catch (e) {
      print('Error adding new residential property: $e');
      return null;
    }
  }

  Future<Property?> addNewCommercial(Property property) async {
    try {
      final Response<Map<String, dynamic>> response =
          await dio.post('/api/properties/Comm', data: property.toJson());

      if (response.data != null) {
        return Property.fromJson(response.data!);
      }

      return null;
    } catch (e) {
      print('Error adding new residential property: $e');
      return null;
    }
  }

  Future<Property?> deleteResidential(Property property) async {
    try {
      final Response<Map<String, dynamic>> response =
          await dio.delete('/api/properties/Res/${property.id}');

      if (response.data != null) {
        return Property.fromJson(response.data!);
      }

      return null;
    } catch (e) {
      print('Error deleting residential property: $e');
      return null;
    }
  }

  Future<Property?> deleteCommercial(Property property) async {
    try {
      final Response<Map<String, dynamic>> response =
          await dio.delete('/api/properties/Comm/${property.id}');

      if (response.data != null) {
        return Property.fromJson(response.data!);
      }

      return null;
    } catch (e) {
      print('Error deleting residential property: $e');
      return null;
    }
  }
}
