import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartControl extends StatefulWidget {
  final void Function(int) addToCart;

  const CartControl({
    super.key,
    required this.addToCart,
  });

  @override
  State<CartControl> createState() => _CartControlState();
}

class _CartControlState extends State<CartControl> {
  int _cartNumber = 1;

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (_cartNumber > 1) {
                _cartNumber--;
              }
            });
          },
          tooltip: l10n?.decreaseCartCount,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: Theme.of(context).colorScheme.onPrimary,
          child: Text(_cartNumber.toString()),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _cartNumber++;
            });
          },
          tooltip: l10n?.increaseCartCount,
        ),
        const Spacer(),
        FilledButton(
          onPressed: () {
            widget.addToCart(_cartNumber);
          },
          child: Text(l10n?.addToTraining ?? 'Add to training'),
        ),
      ],
    );
  }
}