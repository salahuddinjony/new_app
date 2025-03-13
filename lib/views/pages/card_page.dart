import 'package:flutter/material.dart';
import 'package:new_app/home_screen_controller.dart';
import 'package:new_app/models/feature_product.dart';
import 'package:new_app/services/apiResponse.dart';
import 'package:new_app/views/pages/add_to_card_page.dart';

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
  appBar: AppBar(title: Text("Shopping Carts")),
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
                              ? product.reviewOverviewModel.ratingSum /
                                  product.reviewOverviewModel.totalReviews
                              : 0.0;

                          return Container(
                            width: 180,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  // Product Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      imageUrl,
                                      height: 100, // Reduced height to prevent overflow
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween, // Distribute space
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
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Add to Cart Button (Prevents Overflow)
                                          SizedBox(
                                            width: double.infinity,
                                            height: 40, // Set a fixed height
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // Handle add to cart action
                                                 Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return AddToCartPage(
                                                        productName: product.name, 
                                                       productPrice: double.tryParse(product.productPrice.price) ?? 0.0,
                                                        imageUrl: imageUrl,
                                                      ); 
                                                    },
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.teal,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                "Add to Cart",
                                                style: TextStyle(color: Colors.white),
                                                
                                                ),
                                            ),
                                          ),
                                        ],
                                      ),
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
