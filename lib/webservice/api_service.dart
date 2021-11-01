import 'package:dio/dio.dart';
import 'package:my_first_flutter/model/home_response.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://private-4639ce-ecommerce56.apiary-mock.com/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("home")
  Future<List<HomeResponse>> getHomeData();

}