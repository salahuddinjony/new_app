

import 'package:new_app/const.dart';
import 'package:new_app/services/api_service.dart';

import 'models/feature_product.dart';

class HomeScreenRepository{

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<FeatureProduct> fetchFeatureList() async {
  final response = await _helper.get(EndPoint.feature);
  return FeatureProduct.fromJson(response);
  }
}