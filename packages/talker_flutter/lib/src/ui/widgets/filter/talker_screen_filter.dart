import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenFilter extends StatelessWidget {
  const TalkerScreenFilter({
    Key? key,
    required this.controller,
    required this.talkerScreenTheme,
    required this.talker,
    required this.typesController,
    required this.titlesController,
  }) : super(key: key);

  final TalkerScreenController controller;
  final TalkerScreenTheme talkerScreenTheme;
  final TalkerInterface talker;
  final GroupButtonController typesController;
  final GroupButtonController titlesController;

  @override
  Widget build(BuildContext context) {
    final titles = unicTitles.map((e) => e.toString()).toList();
    final types = unicTypes.map((e) => e).toList();
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 80),
      decoration: BoxDecoration(
        color: talkerScreenTheme.backgroudColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: talkerScreenTheme.backgroudColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              boxShadow: const [BoxShadow(blurRadius: 5)],
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Talker Filter',
                  style: theme.textTheme.headline6!
                      .copyWith(color: talkerScreenTheme.textColor),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close_rounded,
                    color: talkerScreenTheme.textColor,
                  ),
                ),
              ],
            ),
          ),
          // Divider(height: 1, color: options.textColor.withOpacity(0.5)),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    style: theme.textTheme.bodyText1!.copyWith(
                      color: talkerScreenTheme.textColor,
                    ),
                    onChanged: controller.updateFilterSearchQuery,
                    decoration: InputDecoration(
                      fillColor: theme.cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: talkerScreenTheme.textColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: talkerScreenTheme.textColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: talkerScreenTheme.textColor,
                      ),
                      hintText: 'Search...',
                      hintStyle: theme.textTheme.bodyText1!.copyWith(
                        color: talkerScreenTheme.textColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Titles',
                    style: theme.textTheme.headline6!.copyWith(
                      color: talkerScreenTheme.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GroupButton(
                    isRadio: false,
                    buttons: titles,
                    controller: titlesController,
                    onSelected: (_, i, selected) {
                      _onToggleTitle(titles[i], selected);
                    },
                    options: GroupButtonOptions(
                      mainGroupAlignment: MainGroupAlignment.start,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Types',
                    style: theme.textTheme.headline6!.copyWith(
                      color: talkerScreenTheme.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GroupButton(
                    isRadio: false,
                    controller: typesController,
                    buttons: types.map((e) => e.toString()).toList(),
                    onSelected: (_, i, selected) {
                      _onToggleType(types[i], selected);
                    },
                    options: GroupButtonOptions(
                      mainGroupAlignment: MainGroupAlignment.start,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onToggleType(Type type, bool selected) {
    if (selected) {
      controller.addFilterType(type);
    } else {
      controller.removeFilterType(type);
    }
  }

  void _onToggleTitle(String title, bool selected) {
    if (selected) {
      controller.addFilterTitle(title);
    } else {
      controller.removeFilterTitle(title);
    }
  }

  Set<Type> get unicTypes {
    return talker.history.map((e) => e.runtimeType).toSet();
  }

  Set<String> get unicTitles {
    return talker.history.map((e) => e.displayTitle).toSet();
  }
}
