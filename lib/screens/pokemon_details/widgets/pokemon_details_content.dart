import 'package:flutter/material.dart';

import '/models/pokemon.dart';
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

  // Tab labels
  final List<String> _tabLabels = [
    'Basic Info',
    'Battle Stats',
    'Egg Details',
    'Base Stats',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main content with padding to avoid overlap
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40.0), // Space for header and button
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vertical Tabs
                VerticalTabs(
                  tabLabels: _tabLabels,
                  selectedIndex: _selectedIndex,
                  onTabSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
                // Tab Content
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      BasicInfoTab(pokemon: widget.pokemon),
                      BattleStatsTab(pokemon: widget.pokemon),
                      EggDetailsTab(pokemon: widget.pokemon),
                      BaseStatsTab(pokemon: widget.pokemon),
                    ],
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
