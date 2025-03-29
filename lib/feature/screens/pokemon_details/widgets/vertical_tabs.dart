import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_dimensions.dart';

class VerticalTabs extends StatelessWidget {
  final List<String> tabLabels;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const VerticalTabs({
    super.key,
    required this.tabLabels,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.withOpacity(Colors.white, 0.2),
            width: 1,
          ),
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: tabLabels.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return _buildTabItem(index, isSelected);
        },
      ),
    );
  }

  Widget _buildTabItem(int index, bool isSelected) {
    return InkWell(
      onTap: () => onTabSelected(index),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.2)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              width: 4,
            ),
            bottom: BorderSide(
              color: AppColors.withOpacity(Colors.white, 0.1),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge),
          child: Center(
            child: Text(
              tabLabels[index],
              style: TextStyle(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.textLight,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
