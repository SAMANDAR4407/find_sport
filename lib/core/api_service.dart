
import 'package:find_sport/models/address.dart';
import 'package:find_sport/models/address_response.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import '../models/user.dart';
import '../models/user_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://qutb.uz/api")
abstract class ApiClient{
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/auth/register')
  Future<UserResponse> registerUser(@Body() User user);

  @POST('/ads')
  Future<AddressResponse> addLocation(@Body() Address address);
}