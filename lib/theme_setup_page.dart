import 'package:flutter/material.dart';

class ThemeSetupPage extends StatelessWidget {
  const ThemeSetupPage({
    super.key,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
    required this.currentSeedColor,
    required this.onSeedColorChanged,
  });

  static const String route = '/theme-setup';
  static const String title = 'Theme Setup';
  static const String subtitle = '앱 테마 모드와 포인트 색상을 변경합니다.';

  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final Color currentSeedColor;
  final ValueChanged<Color> onSeedColorChanged;

  static const List<Color> _presetColors = <Color>[
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.orange,
    Colors.green,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            '테마 모드',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            segments: const <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                value: ThemeMode.system,
                label: Text('시스템'),
                icon: Icon(Icons.settings_suggest_outlined),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.light,
                label: Text('라이트'),
                icon: Icon(Icons.light_mode_outlined),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.dark,
                label: Text('다크'),
                icon: Icon(Icons.dark_mode_outlined),
              ),
            ],
            selected: <ThemeMode>{currentThemeMode},
            onSelectionChanged: (Set<ThemeMode> selected) {
              onThemeModeChanged(selected.first);
            },
          ),
          const SizedBox(height: 24),
          Text(
            '포인트 색상',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _presetColors
                .map(
                  (Color color) => _ColorChoiceChip(
                    color: color,
                    selected: color.value == currentSeedColor.value,
                    onTap: () => onSeedColorChanged(color),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ColorChoiceChip extends StatelessWidget {
  const _ColorChoiceChip({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.onSurface
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: selected
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
