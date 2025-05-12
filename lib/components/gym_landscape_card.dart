// gym_landscape_card.dart
import 'package:flutter/material.dart';
import '../models/gym.dart';

class GymLandscapeCard extends StatefulWidget {
  final Gym gym;
  final Function() onTap;

  const GymLandscapeCard({
    super.key,
    required this.gym,
    required this.onTap,
  });

  @override
  State<GymLandscapeCard> createState() => _GymLandscapeCardState();
}

class _GymLandscapeCardState extends State<GymLandscapeCard> with SingleTickerProviderStateMixin {
  bool _isFavorited = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              widget.onTap();
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'gym-${widget.gym.id}',
                        child: Image.asset(
                          widget.gym.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavorited = !_isFavorited;
                            });
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: _isFavorited
                                ? const Icon(
                              Icons.favorite,
                              key: ValueKey('favorite'),
                              color: Colors.red,
                              size: 30,
                            )
                                : const Icon(
                              Icons.favorite_border,
                              key: ValueKey('not_favorite'),
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    widget.gym.name,
                    style: textTheme.titleSmall,
                  ),
                  subtitle: Text(
                    widget.gym.attributes,
                    maxLines: 1,
                    style: textTheme.bodySmall,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: widget.onTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}