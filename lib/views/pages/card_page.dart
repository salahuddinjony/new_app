import 'package:flutter/material.dart';
import 'package:new_app/home_screen_controller.dart';
import 'package:new_app/models/feature_product.dart';
import 'package:new_app/services/apiResponse.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  
  late HomeScreenController _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomeScreenController();
    _bloc.fetchFeaturedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(title: Text("Shoping Cards")),
  body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: StreamBuilder<ApiResponse<FeatureProduct>>(
      stream: _bloc.featureProductStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());

            case Status.COMPLETED:
              var productList = snapshot.data!.data!.data;

              return productList.isNotEmpty
                  ? SizedBox(
                      height: 250, 
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          var product = productList[index];
                          String imageUrl = product.pictureModels.isNotEmpty
                              ? product.pictureModels[0].imageUrl
                              : 'https://via.placeholder.com/150'; // Fallback image
                          double rating = product.reviewOverviewModel.totalReviews > 0 
                              ? product.reviewOverviewModel.ratingSum / product.reviewOverviewModel.totalReviews 
                              : 0.0;

                          return Container(
                            width: 180,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Product Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                        child: Image.network(
                                          imageUrl,
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Product Price
                                            Text(
                                              "QAR ${product.productPrice.price}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.teal,
                                              ),
                                            ),
                                            SizedBox(height: 5),

                                            // Product Name
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 5),

                                            // Product Rating
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.orange,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  rating.toStringAsFixed(1),
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // New Badge
                                  if (product.markAsNew)
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.brown,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "New",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),

                                  // Favorite Button (Heart)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        // Handle favorite action
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(child: Text("No products available"));

            case Status.ERROR:
              return Center(child: Text("Error fetching data"));

            default:
              return SizedBox.shrink();
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    ),
  ),
);
  }
}
