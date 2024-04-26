class Site {
  final int id;
  final String name;
  final int acres;
  final String dateOfCulture;
  final int maxDoc;
  final int minDoc;
  final String lastUpdated;
  final double totalFeed;
  final String feedLastUpdated;
  final String? nettingLastUpdated;
  final double feedConversionRatio;
  final double assetValue;
  final double seed;

  Site({
    required this.id,
    required this.name,
    required this.acres,
    required this.dateOfCulture,
    required this.maxDoc,
    required this.minDoc,
    required this.lastUpdated,
    required this.totalFeed,
    required this.feedLastUpdated,
    required this.nettingLastUpdated,
    required this.feedConversionRatio,
    required this.assetValue,
    required this.seed,
  });

  factory Site.fromJson(Map<String, dynamic> json) => Site(
        id: json["id"],
        name: json["name"],
        acres: json["acres"],
        dateOfCulture: json["date_of_culture"],
        maxDoc: json["max_doc"],
        minDoc: json["min_doc"],
        lastUpdated: json["last_updated"],
        totalFeed: json["total_feed"]?.toDouble(),
        feedLastUpdated: json["feed_last_updated"],
        nettingLastUpdated: json['netting_last_updated'],
        feedConversionRatio: json["feed_conversion_ratio"]?.toDouble(),
        assetValue: json["asset_value"]?.toDouble(),
        seed: json["seed"]?.toDouble(),
      );
}
