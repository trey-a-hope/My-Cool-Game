import 'package:bonfire/bonfire.dart';

mixin ScreenBoundaryChecker on GameComponent {
  void checkScreenBoundaries() {
    // Left boundary.
    if (position.x < 0) {
      position.x = 0;
    }
    // Top boundary.
    if (position.y < 0) {
      position.y = 0;
    }

    // Right boundary.
    if (position.x + width > gameRef.size.x) {
      position.x = gameRef.size.x - width;
    }

    // Bottom boundary.
    if (position.y + height > gameRef.size.y) {
      position.y = gameRef.size.y - height;
    }
  }
}
