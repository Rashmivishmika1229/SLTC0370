import 'package:flutter/material.dart';
import '../widgets/top_bar.dart';
import 'catalogue_screen.dart';
import '../widgets/category_drawer.dart';
import 'dart:ui';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showDrawer = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/bg2.jpg", fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(132, 0, 0, 0).withOpacity(0.7),
                  const Color.fromARGB(48, 0, 0, 0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(
                    onMenuTap: () {
                      setState(() {
                        showDrawer = true;
                      });
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "WELCOME, USER!",
                        style: TextStyle(
                          fontFamily: "OpenSansHebrew",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(221, 255, 255, 255),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: "",
                                hintStyle: TextStyle(
                                  fontFamily: "OpenSansHebrew",
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                print("Search tapped");
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFFE8789D),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 180,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 40,
                          child: Container(
                            height: 122,
                            width: width,
                            color: const Color.fromARGB(182, 232, 120, 157),
                          ),
                        ),

                        Positioned(
                          right: 90,
                          top: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "20% Off\nwith",
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Party Wear",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "PlayfairDisplay",
                                ),
                              ),
                              const SizedBox(height: 3),

                              Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    print("More offers tapped");
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      "MORE OFFERS",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xFFE8789D),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          left: 50,
                          bottom: 18,
                          child: Image.asset(
                            "assets/images/banner2.png",
                            height: 180,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  const CategorySection(),

                  const PopularDealsSection(),
                ],
              ),
            ),
          ),
          if (showDrawer)
            GestureDetector(
              onTap: () {
                setState(() {
                  showDrawer = false;
                });
              },
              child: Container(
                color: const Color.fromARGB(
                  255,
                  254,
                  253,
                  253,
                ).withOpacity(0.3),
              ),
            ),

          if (showDrawer) CategoryDrawer(isOpen: showDrawer),
        ],
      ),
    );
  }
}

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<Map<String, String>> categories = [
    {"name": "CASUAL", "image": "assets/images/casual.jpg"},
    {"name": "FORMAL", "image": "assets/images/formal.jpg"},
    {"name": "PARTY", "image": "assets/images/party.jpg"},
    {"name": "ACTIVE", "image": "assets/images/active.jpg"},
    {"name": "ETHNIC", "image": "assets/images/ethnic.jpg"},
    {"name": "LOUNGE", "image": "assets/images/lounge.jpg"},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (categories.length / 2).ceil();

    return Column(
      children: [
        /// TITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "CATEGORIES",
              style: TextStyle(
                color: Color(0xFFE8789D),
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 150,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (!_controller.hasClients) return;
                  if (currentPage > 0) {
                    final newPage = currentPage - 1;

                    _controller.animateToPage(
                      newPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    setState(() {
                      currentPage = newPage;
                    });
                  }
                },
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,

                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },

                  itemCount: totalPages,

                  itemBuilder: (context, pageIndex) {
                    final start = pageIndex * 2;

                    final end = (start + 2 > categories.length)
                        ? categories.length
                        : start + 2;

                    final items = categories.sublist(start, end);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: items.map((cat) {
                        return Expanded(child: _CategoryCard(cat));
                      }).toList(),
                    );
                  },
                ),
              ),

              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  if (!_controller.hasClients) return;

                  if (currentPage < totalPages - 1) {
                    final newPage = currentPage + 1;

                    _controller.animateToPage(
                      newPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    setState(() {
                      currentPage = newPage;
                    });
                  }
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final Map<String, String> cat;

  const _CategoryCard(this.cat);

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final cat = widget.cat;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),

      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CatalogueScreen()),
          );
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 140,

          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(cat["image"]!, fit: BoxFit.cover),
                ),

                Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.35)),
                ),

                Positioned.fill(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    color: isHovering
                        ? Colors.black.withOpacity(0.25)
                        : Colors.transparent,
                  ),
                ),

                Center(
                  child: Text(
                    cat["name"]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
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

class PopularDealsSection extends StatefulWidget {
  const PopularDealsSection({super.key});

  @override
  State<PopularDealsSection> createState() => _PopularDealsSectionState();
}

class _PopularDealsSectionState extends State<PopularDealsSection> {
  final PageController _controller = PageController();

  int currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> deals = [
    {
      "name": "Jen Turtleneck Tee",
      "price": "LKR 8,500",
      "image": "assets/images/casual.jpg",
    },
    {
      "name": "Glimmer Dress",
      "price": "LKR 10,500",
      "image": "assets/images/ethnic.jpg",
    },
    {
      "name": "Hypersport Duo",
      "price": "LKR 6,000",
      "image": "assets/images/active.jpg",
    },
    {
      "name": "Evenstar Gown",
      "price": "LKR 12,000",
      "image": "assets/images/party.jpg",
    },
    {
      "name": "Lolita Summer Dress",
      "price": "LKR 7,500",
      "image": "assets/images/lounge.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_controller.hasClients) return;

      currentPage++;

      if (currentPage >= deals.length) {
        currentPage = 0;
      }

      _controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "POPULAR DEALS",
              style: TextStyle(
                color: Color(0xFFE8789D),
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: _controller,

            onPageChanged: (index) {
              currentPage = index;
            },

            itemCount: deals.length,
            itemBuilder: (context, index) {
              return _dealCard(deals[index]);
            },
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _dealCard(Map<String, String> deal) {
    final name = deal["name"] ?? "No Name";
    final price = deal["price"] ?? "";
    final image = deal["image"] ?? "";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CatalogueScreen()),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Positioned.fill(
                child: image.isNotEmpty
                    ? Image.asset(image, fit: BoxFit.cover)
                    : Container(color: Colors.grey), // fallback
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
