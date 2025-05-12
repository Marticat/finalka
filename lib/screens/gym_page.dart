import 'package:flutter/material.dart';
import '../components/item_details.dart';
import '../models/workout_manager.dart';
import '../models/plan_manager.dart';
import '../models/gym.dart';

class RestaurantPage extends StatefulWidget {
  final Gym gym;
  final CartManager cartManager;
  final PlanManager planManager;

  const RestaurantPage({
    super.key,
    required this.gym,
    required this.cartManager,
    required this.planManager,
  });

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> with SingleTickerProviderStateMixin {
  static const double largeScreenPercentage = 0.9;
  static const double maxWidth = 1000;
  static const desktopThreshold = 700;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _calculateConstrainedWidth(double screenWidth) {
    return (screenWidth > desktopThreshold
        ? screenWidth * largeScreenPercentage
        : screenWidth)
        .clamp(0.0, maxWidth);
  }

  int calculateColumnCount(double screenWidth) {
    return screenWidth > desktopThreshold ? 2 : 1;
  }

  Widget _buildInfoSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Gym Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  Widget _buildGridViewSection(String title) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
            color: Colors.grey[200],
            child: Center(child: Text('Item $index')),
          ),
          childCount: 4,
        ),
      ),
    );
  }


  Widget _buildEndDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }

  CustomScrollView _buildCustomScrollView() {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        _buildInfoSection(),
        _buildGridViewSection('Plan'),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 280.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'gym-${widget.gym.id}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                widget.gym.imageUrl,
                fit: BoxFit.cover,
                color: const Color.fromRGBO(0, 0, 0, 0.3),
                colorBlendMode: BlendMode.darken,
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.gym.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final constrainedWidth = _calculateConstrainedWidth(screenWidth);

    return Scaffold(
      key: scaffoldKey,
      endDrawer: _buildEndDrawer(),
      floatingActionButton: _buildFloatingActionButton(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: SizedBox(
            width: constrainedWidth,
            child: _buildCustomScrollView(),
          ),
        ),
      ),
    );
  }
}