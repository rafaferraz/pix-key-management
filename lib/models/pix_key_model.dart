class PixKey {
  String? id;
  String key;
  String bank;
  PixKey({
    this.id,
    required this.key,
    required this.bank,
  });

  static PixKey fromJson(element) {
    return PixKey(
      id: element.id,
      key: element.data()['key'],
      bank: element.data()['bank'],
    );
  }

  PixKey copyWith({
    String? idCP,
    String? keyCP,
    String? bankCP,
  }) {
    return PixKey(
      key: keyCP ?? this.key,
      bank: bankCP ?? this.bank,
      id: idCP ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['key'] = key;
    _data['bank'] = bank;
    return _data;
  }
}
