import 'package:flutter/material.dart';

import '/core/themes/app_dimensions.dart';
import '../../../models/pokemon.dart';
import 'base_stats_tab.dart';
import 'basic_info_tab.dart';
import 'battle_stats_tab.dart';
import 'egg_details_tab.dart';
import 'vertical_tabs.dart';

class PokemonDetailsContent extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetailsContent({super.key, required this.pokemon});

  @override
  _PokemonDetailsContentState createState() => _PokemonDetailsContentState();
}

class _PokemonDetailsContentState extends State<PokemonDetailsContent> {
  int _selectedIndex = 0;

  final tabs = [
    {'label': 'Basic Info', 'widget': (Pokemon p) => BasicInfoTab(pokemon: p)},
    {
      'label': 'Battle Stats',
      'widget': (Pokemon p) => BattleStatsTab(pokemon: p)
    },
    {
      'label': 'Egg Details',
      'widget': (Pokemon p) => EggDetailsTab(pokemon: p)
    },
    {'label': 'Base Stats', 'widget': (Pokemon p) => BaseStatsTab(pokemon: p)},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppDimensions.paddingXLarge),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalTabs(
                  tabLabels: tabs.map((tab) => tab['label'] as String).toList(),
                  selectedIndex: _selectedIndex,
                  onTabSelected: (index) =>
                      setState(() => _selectedIndex = index),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: tabs
                        .map((tab) => (tab['widget'] as Widget Function(
                            Pokemon))(widget.pokemon))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
