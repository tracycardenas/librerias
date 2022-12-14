import 'package:dio/dio.dart';
import 'package:listar/app/data/model/libro.dart';

class ListarApi {
  static Dio dio = Dio();

  static void configureDio() {
    dio.options.baseUrl = 'http://34.176.83.39:8080/demoapp/rs';
  }

  Future<List<Libro>?> getList() async {
    var result;
    try {
      result = await dio.get(
        '/libros',
      );
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        if (e.response!.data['errors'] != null) {
          throw (e.response!.data['errors'][0]['msg']);
        } else {
          throw (e.response!.data['msg']);
        }
      } else {
        throw ('Error');
      }
    }
    print(result);
    return (result as List)
        .map((e) => Libro.fromJson(e))
        .toList()
        .cast<Libro>();
  }

  Future getHttp() async {
    try {
      print("Entre");
      var response = await Dio().get('');
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
