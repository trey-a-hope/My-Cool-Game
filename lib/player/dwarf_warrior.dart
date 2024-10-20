import 'package:bonfire/bonfire.dart';
import 'package:my_cool_game/sprite_animations.dart';

enum OtherAnimation {
  attack,
  hurt,
  death,
}

class DwarfWarrior extends PlatformPlayer
    with HandleForces, KeyboardEventListener {
  static const _jumpSpeed = 100.0;
  static const _speed = 150.0;
  static const _size = 60.0;

  OtherAnimation? _otherAnimation;

  DwarfWarrior({
    required super.position,
  }) : super(
          size: Vector2.all(_size),
          life: 100,
          speed: 100,
          countJumps: 1,
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorWalk,
            others: {
              'attack': SpriteAnimations.dwarfWarriorAttack,
              'hurt': SpriteAnimations.dwarfWarriorHurt,
              'death': SpriteAnimations.dwarfWarriorDeath,
            },
          ),
        ) {
    addForce(
      AccelerationForce2D(
        id: 'gravity',
        value: Vector2(0, _jumpSpeed * 2),
      ),
    );
  }

  @override
  void update(double dt) {
    // TODO: Do not place these inside the udpate method,
    // but rather the die, attack, and receiveDamage overrides.
    _otherAnimation = OtherAnimation.attack;

    switch (_otherAnimation) {
      case null:
      case OtherAnimation.hurt:
        animation!.playOther('hurt');
      case OtherAnimation.death:
        animation!.playOther('death');
      case OtherAnimation.attack:
        animation!.playOther('attack');
    }

    super.update(dt);
  }

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2.all(size.x / 2),
        position: Vector2(size.x / 4, size.x / 2),
        isSolid: true,
      ),
    );
    return super.onLoad();
  }
}
