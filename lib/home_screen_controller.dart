import 'dart:async';

import 'package:new_app/base_bloc.dart';
import 'package:new_app/home_screen_repository.dart';
import 'package:new_app/services/apiResponse.dart';

import 'models/feature_product.dart';

class HomeScreenController extends BaseBloc {
  late HomeScreenRepository _repository;
  StreamController? _featureProduct;

  // Manufacturers stream controller
  StreamSink<ApiResponse<FeatureProduct>> get featureProductSink =>
      _featureProduct!.sink as StreamSink<ApiResponse<FeatureProduct>>;
  Stream<ApiResponse<FeatureProduct>> get featureProductStream =>
      _featureProduct!.stream as Stream<ApiResponse<FeatureProduct>>;

  HomeScreenController() {
    _repository = HomeScreenRepository();
    _featureProduct = StreamController<ApiResponse<FeatureProduct>>();
  }

  @override
  void dispose() {
    _featureProduct?.close();
  }

  fetchFeaturedProduct() async {
    featureProductSink.add(ApiResponse.loading());

    try {
      var featuredProduct = await _repository.fetchFeatureList();
      featureProductSink.add(ApiResponse.completed(featuredProduct));
    } catch (e) {
      featureProductSink.add(ApiResponse.error(e.toString()));
    }
  }

}