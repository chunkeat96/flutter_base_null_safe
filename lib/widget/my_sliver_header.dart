import 'package:flutter/material.dart';

class MySliverHeader extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;

  MySliverHeader({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(MySliverHeader oldDelegate) {
    return child != oldDelegate.child;
  }

}