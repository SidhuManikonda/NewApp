import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:data_table_2/data_table_2.dart';
import 'package:local_json_read/models/sitemodel.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableHomeState();
}

class _TableHomeState extends State<TableView> {
  List<Site> items = [];
  List filterlist = [];
  late TextEditingController _searchcontroller;

  @override
  void initState() {
    super.initState();
    _searchcontroller = TextEditingController();
    loadJson();
  }

  void searchfilter(String enteredkeyword) {
    setState(() {
      filterlist = items
          .where((site) =>
              site.name.toLowerCase().contains(enteredkeyword.toLowerCase()))
          .toList();
    });
  }

  Future<void> loadJson() async {
    try {
      final String response = await rootBundle.loadString('assets/local.json');
      final data = jsonDecode(response);

      setState(() {
        items = List<Site>.from(
            data['sites'].map((siteJson) => Site.fromJson(siteJson)));
        filterlist = List<Site>.from(items);
      });
    } catch (error) {
      throw Exception('$error');
    }
  }

  final List<Map<String, dynamic>> columns = const [
    {'label': Text('ID'), 'fixedWidth': 50},
    {'label': Text('Site Name'), 'fixedWidth': 150},
    {'label': Text('Acres')},
    {'label': Text('Doc')},
    {'label': Text('Min/max DOC'), 'fixedWidth': 100},
    {'label': Text('Date Updated'), 'fixedWidth': 150},
    {'label': Text('Feed Last Updated'), 'fixedWidth': 150},
    {'label': Text('Neeting Last Updated'), 'fixedWidth': 150},
    {'label': Text('FCR'), 'fixedWidth': 100},
    {'label': Text('Asset Value in Lakhs')},
    {'label': Text('Total Feed')},
    {'label': Text('Total Seed count')},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Next Farm'),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Farm Summary',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: TextFormField(
                      onChanged: searchfilter,
                      controller: _searchcontroller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'search farm',
                        filled: true,
                        fillColor: Color(0xFFF2F2F2),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                            width: 1,
                          ),
                        ),
                        hintText: "Search farm name",
                        suffixIcon: Icon(Icons.search),
                        hintStyle:
                            TextStyle(fontSize: 16, color: Color(0xFFB3B1B1)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: DataTable2(
                minWidth: 1200,
                isHorizontalScrollBarVisible: true,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue),
                headingRowHeight: 50,
                dataRowHeight: 80,
                decoration: const BoxDecoration(),
                border: TableBorder.all(color: Colors.black, width: 0.5),
                columns: columns.map<DataColumn2>((column) {
                  return DataColumn2(
                    label: column['label'],
                    fixedWidth: column['fixedWidth'],
                  );
                }).toList(),
                rows: items
                    .map(
                      (site) => DataRow(
                        cells: [
                          DataCell(Text(site.id.toString())),
                          DataCell(Text(site.name)),
                          DataCell(Text(site.acres.toString())),
                          DataCell(Text(site.dateOfCulture)),
                          DataCell(Text('${site.minDoc}/${site.maxDoc}')),
                          DataCell(Text(site.lastUpdated)),
                          DataCell(Text(site.feedLastUpdated)),
                          DataCell(Text(site.nettingLastUpdated != null
                              ? site.nettingLastUpdated!
                              : '--')),
                          DataCell(Text(site.feedConversionRatio.toString())),
                          DataCell(Text(site.assetValue.toString())),
                          DataCell(Text(site.totalFeed.toString())),
                          DataCell(Text(site.seed.toString())),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
