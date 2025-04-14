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
  State<GymLandscapeCard> createState() =>
      _GymLandscapeCardState();
}

class _GymLandscapeCardState extends State<GymLandscapeCard> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8.0),
            ),
            child: AspectRatio(
              aspectRatio: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.gym.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 4.0,
                    right: 4.0,
                    child: IconButton(
                      icon: Icon(
                        _isFavorited
                            ? Icons.favorite //
                            : Icons.favorite_border,
                      ),
                      iconSize: 30.0,
                      color: Colors.red[400],
                      onPressed: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                        });
                      },
                    ),
                  ),
                ],
              ),
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
            onTap: widget.onTap,
          ),
        ],
      ),
    );
  }
}
