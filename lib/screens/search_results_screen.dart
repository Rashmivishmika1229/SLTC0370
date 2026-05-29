import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/firestore_service.dart';
import '../widgets/category_drawer.dart';
import 'productdetails_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultsScreen({super.key, required this.searchQuery});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool showDrawer = false;

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/bg2.jpg", fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),

              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.8)),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  child: Row(
                    children: [
                      Material(
                        color: Colors.white.withOpacity(0.08),

                        borderRadius: BorderRadius.circular(14),

                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),

                          onTap: () {
                            Navigator.pop(context);
                          },

                          child: const Padding(
                            padding: EdgeInsets.all(10),

                            child: Icon(
                              Icons.arrow_back_ios_new,

                              color: Colors.white,

                              size: 18,
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      /// MENU
                      Material(
                        color: Colors.white.withOpacity(0.08),

                        borderRadius: BorderRadius.circular(14),

                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),

                          onTap: () {
                            setState(() {
                              showDrawer = true;
                            });
                          },

                          child: const Padding(
                            padding: EdgeInsets.all(10),

                            child: Icon(
                              Icons.menu,

                              color: Colors.white,

                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: Column(
                    children: [
                      const Text(
                        "SEARCH RESULTS",

                        style: TextStyle(
                          fontFamily: "OpenSansHebrew",

                          color: Color(0xFFE8789D),

                          fontWeight: FontWeight.w800,

                          fontSize: 20,

                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Results for "${widget.searchQuery}"',

                        style: const TextStyle(
                          color: Colors.white70,

                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// PRODUCTS
                Expanded(
                  child: StreamBuilder<List<ProductModel>>(
                    stream: firestoreService.getProducts(),

                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Products Found",

                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final allProducts = snapshot.data!;

                      /// FILTER PRODUCTS
                      final filteredProducts = allProducts.where((product) {
                        final query = widget.searchQuery.toLowerCase();

                        final name = product.name.toLowerCase();

                        final category = product.category.toLowerCase();

                        final description = product.description.toLowerCase();

                        return name.contains(query) ||
                            category.contains(query) ||
                            description.contains(query) ||
                            (query.contains("dress") &&
                                (category.contains("party") ||
                                    category.contains("formal") ||
                                    name.contains("gown") ||
                                    name.contains("dress"))) ||
                            (query.contains("skirt") &&
                                name.contains("skirt")) ||
                            (query.contains("casual") &&
                                category.contains("casual"));
                      }).toList();

                      if (filteredProducts.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Matching Products",

                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(12),

                        itemCount: filteredProducts.length,

                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: width < 400 ? 1 : 2,

                          mainAxisSpacing: 12,

                          crossAxisSpacing: 12,

                          childAspectRatio: width < 400 ? 0.72 : 0.55,
                        ),

                        itemBuilder: (_, index) {
                          final product = filteredProducts[index];

                          return ProductTile(product: product);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          if (showDrawer)
            GestureDetector(
              onTap: () {
                setState(() {
                  showDrawer = false;
                });
              },

              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

          /// DRAWER
          if (showDrawer) CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }
}

/// PRODUCT
class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),

      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },

      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),

        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),

              borderRadius: BorderRadius.circular(24),

              border: Border.all(color: Colors.white12),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),

                    child: Image.network(
                      product.image,

                      width: double.infinity,

                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        product.name,

                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,

                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "LKR ${product.price}",

                        style: const TextStyle(
                          color: Color(0xFFE8789D),

                          fontWeight: FontWeight.w600,

                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
