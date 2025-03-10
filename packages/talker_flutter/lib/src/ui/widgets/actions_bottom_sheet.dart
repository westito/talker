import 'package:flutter/material.dart';

import 'package:talker_flutter/talker_flutter.dart';

class ActionsBottomSheet extends StatelessWidget {
  const ActionsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.actions,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;
  final List<BottomSheetAction> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: talkerScreenTheme.backgroudColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actions
              .map(
                (e) => _ActionTile(
                  talkerScreenTheme: talkerScreenTheme,
                  action: e,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    Key? key,
    required this.action,
    required this.talkerScreenTheme,
  }) : super(key: key);

  final BottomSheetAction action;
  final TalkerScreenTheme talkerScreenTheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        action.onTap();
      },
      title: Text(
        action.title,
        style: TextStyle(
          color: talkerScreenTheme.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Icon(
        action.icon,
        color: talkerScreenTheme.iconsColor,
      ),
    );
  }
}

class BottomSheetAction {
  const BottomSheetAction({
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
}
