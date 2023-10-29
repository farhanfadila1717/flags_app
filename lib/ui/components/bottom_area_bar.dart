import 'package:flutter/material.dart';

class BottomAreaBar extends StatelessWidget {
  const BottomAreaBar({
    super.key,
    required this.children,
    this.padding,
    this.decoration,
    this.withShadow = false,
  });

  final List<Widget> children;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final bool withShadow;

  const BottomAreaBar.transparent({
    Key? key,
    required this.children,
    this.decoration = const BoxDecoration(),
    this.padding,
    this.withShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: decoration ??
          BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            boxShadow: withShadow
                ? [
                    const BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
