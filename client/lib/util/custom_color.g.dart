import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const customred = Color(0xFFC60047);
const customblue = Color(0xFF4EA0FF);


CustomColors lightCustomColors = const CustomColors(
  sourceCustomred: Color(0xFFC60047),
  customred: Color(0xFFBD0043),
  onCustomred: Color(0xFFFFFFFF),
  customredContainer: Color(0xFFFFD9DC),
  onCustomredContainer: Color(0xFF400011),
  sourceCustomblue: Color(0xFF4EA0FF),
  customblue: Color(0xFF005FAC),
  onCustomblue: Color(0xFFFFFFFF),
  customblueContainer: Color(0xFFD4E3FF),
  onCustomblueContainer: Color(0xFF001C39),
);

CustomColors darkCustomColors = const CustomColors(
  sourceCustomred: Color(0xFFC60047),
  customred: Color(0xFFFFB2BB),
  onCustomred: Color(0xFF670021),
  customredContainer: Color(0xFF910032),
  onCustomredContainer: Color(0xFFFFD9DC),
  sourceCustomblue: Color(0xFF4EA0FF),
  customblue: Color(0xFFA4C9FF),
  onCustomblue: Color(0xFF00315D),
  customblueContainer: Color(0xFF004884),
  onCustomblueContainer: Color(0xFFD4E3FF),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceCustomred,
    required this.customred,
    required this.onCustomred,
    required this.customredContainer,
    required this.onCustomredContainer,
    required this.sourceCustomblue,
    required this.customblue,
    required this.onCustomblue,
    required this.customblueContainer,
    required this.onCustomblueContainer,
  });

  final Color? sourceCustomred;
  final Color? customred;
  final Color? onCustomred;
  final Color? customredContainer;
  final Color? onCustomredContainer;
  final Color? sourceCustomblue;
  final Color? customblue;
  final Color? onCustomblue;
  final Color? customblueContainer;
  final Color? onCustomblueContainer;

  @override
  CustomColors copyWith({
    Color? sourceCustomred,
    Color? customred,
    Color? onCustomred,
    Color? customredContainer,
    Color? onCustomredContainer,
    Color? sourceCustomblue,
    Color? customblue,
    Color? onCustomblue,
    Color? customblueContainer,
    Color? onCustomblueContainer,
  }) {
    return CustomColors(
      sourceCustomred: sourceCustomred ?? this.sourceCustomred,
      customred: customred ?? this.customred,
      onCustomred: onCustomred ?? this.onCustomred,
      customredContainer: customredContainer ?? this.customredContainer,
      onCustomredContainer: onCustomredContainer ?? this.onCustomredContainer,
      sourceCustomblue: sourceCustomblue ?? this.sourceCustomblue,
      customblue: customblue ?? this.customblue,
      onCustomblue: onCustomblue ?? this.onCustomblue,
      customblueContainer: customblueContainer ?? this.customblueContainer,
      onCustomblueContainer: onCustomblueContainer ?? this.onCustomblueContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceCustomred: Color.lerp(sourceCustomred, other.sourceCustomred, t),
      customred: Color.lerp(customred, other.customred, t),
      onCustomred: Color.lerp(onCustomred, other.onCustomred, t),
      customredContainer: Color.lerp(customredContainer, other.customredContainer, t),
      onCustomredContainer: Color.lerp(onCustomredContainer, other.onCustomredContainer, t),
      sourceCustomblue: Color.lerp(sourceCustomblue, other.sourceCustomblue, t),
      customblue: Color.lerp(customblue, other.customblue, t),
      onCustomblue: Color.lerp(onCustomblue, other.onCustomblue, t),
      customblueContainer: Color.lerp(customblueContainer, other.customblueContainer, t),
      onCustomblueContainer: Color.lerp(onCustomblueContainer, other.onCustomblueContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
    );
  }
}