import 'package:flutter/material.dart';

import '../assets.dart';

class PokemonType {
  final String type;
  final Color color;
  final String imagePath;

  PokemonType({
    required this.type,
    required this.color,
    required this.imagePath,
  });
}

class PokemonTypes {
  static final Map<String, PokemonType> types = {
    "Bug": PokemonType(
      type: "Bug",
      color: Color(0xFF92BC2C),
      imagePath: Assets.kBugType,
    ),
    "Dark": PokemonType(
      type: "Dark",
      color: Color(0xFF595761),
      imagePath: Assets.kDarkType,
    ),
    "Dragon": PokemonType(
      type: "Dragon",
      color: Color(0xFF0C69C8),
      imagePath: Assets.kDragonType,
    ),
    "Electric": PokemonType(
      type: "Electric",
      color: Color(0xFFEDD53E),
      imagePath: Assets.kElectricType,
    ),
    "Fairy": PokemonType(
      type: "Fairy",
      color: Color(0xFFEC8CE5),
      imagePath: Assets.kFairyType,
    ),
    "Fighting": PokemonType(
      type: "Fighting",
      color: Color(0xFFCE4265),
      imagePath: Assets.kFightingType,
    ),
    "Fire": PokemonType(
      type: "Fire",
      color: Color(0xFFFB9B51),
      imagePath: Assets.kFireType,
    ),
    "Flying": PokemonType(
      type: "Flying",
      color: Color(0xFF90A7DA),
      imagePath: Assets.kFlyingType,
    ),
    "Ghost": PokemonType(
      type: "Ghost",
      color: Color(0xFF516AAC),
      imagePath: Assets.kGhostType,
    ),
    "Grass": PokemonType(
      type: "Grass",
      color: Color(0xFF5FBC51),
      imagePath: Assets.kGrassType,
    ),
    "Ground": PokemonType(
      type: "Ground",
      color: Color(0xFFDC7545),
      imagePath: Assets.kGroundType,
    ),
    "Ice": PokemonType(
      type: "Ice",
      color: Color(0xFF70CCBD),
      imagePath: Assets.kIceType,
    ),
    "Normal": PokemonType(
      type: "Normal",
      color: Color(0xFF9298A4),
      imagePath: Assets.kNormalType,
    ),
    "Poison": PokemonType(
      type: "Poison",
      color: Color(0xFFA864C7),
      imagePath: Assets.kPoisonType,
    ),
    "Psychic": PokemonType(
      type: "Psychic",
      color: Color(0xFFF66F71),
      imagePath: Assets.kPsychicType,
    ),
    "Rock": PokemonType(
      type: "Rock",
      color: Color(0xFFC5B489),
      imagePath: Assets.kRockType,
    ),
    "Steel": PokemonType(
      type: "Steel",
      color: Color(0xFF52869D),
      imagePath: Assets.kSteelType,
    ),
    "Water": PokemonType(
      type: "Water",
      color: Color(0xFF4A90DD),
      imagePath: Assets.kWaterType,
    ),
  };
}
