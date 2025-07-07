class BookSource {
  final int? id;
  final String name;
  final String url;
  final String rules; // JSON string
  final int sourceType; // 0 for HTML, 1 for API
  final bool isEnabled;
  final int lastUpdated;
  final int createdAt;

  BookSource({
    this.id,
    required this.name,
    required this.url,
    required this.rules,
    this.sourceType = 0,
    required this.isEnabled,
    required this.lastUpdated,
    required this.createdAt,
  });

  BookSource copyWith({
    int? id,
    String? name,
    String? url,
    String? rules,
    int? sourceType,
    bool? isEnabled,
    int? lastUpdated,
    int? createdAt,
  }) {
    return BookSource(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      rules: rules ?? this.rules,
      sourceType: sourceType ?? this.sourceType,
      isEnabled: isEnabled ?? this.isEnabled,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'rules': rules,
      'sourceType': sourceType,
      'isEnabled': isEnabled ? 1 : 0,
      'lastUpdated': lastUpdated,
      'createdAt': createdAt,
    };
  }

  factory BookSource.fromMap(Map<String, dynamic> map) {
    return BookSource(
      id: map['id'],
      name: map['name'],
      url: map['url'],
      rules: map['rules'],
      sourceType: map['sourceType'] ?? 0,
      isEnabled: map['isEnabled'] == 1,
      lastUpdated: map['lastUpdated'],
      createdAt: map['createdAt'],
    );
  }
}
