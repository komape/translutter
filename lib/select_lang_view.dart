import 'package:flutter/material.dart';

import 'lang.dart';

class SelectLangView extends StatelessWidget {
  final String title;
  final List<Lang> langs;

  const SelectLangView({
    Key? key,
    required this.title,
    required this.langs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style:
              Theme.of(context).textTheme.subtitle1!.apply(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context), icon: Icon(Icons.clear))
        ],
      ),
      body: ListView.builder(
        itemCount: langs.length,
        itemBuilder: (BuildContext context, int idx) => Padding(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
          child: ListTile(
            onTap: () => Navigator.pop(context, langs[idx]),
            horizontalTitleGap: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: Colors.grey.shade200,
            leading: Text(
              langs[idx].flagEmoji,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            title: Text(
              langs[idx].name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }
}
