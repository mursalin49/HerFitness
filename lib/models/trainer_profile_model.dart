class TrainerProfileModel {
  final String? id;
  final String name;
  final String specialty;
  final String price;
  final double rating;
  final int? reviewCount;
  final String imageUrl;
  final String distance;
  final String bio;
  final double? lat;
  final double? lng;

  const TrainerProfileModel({
    this.id,
    required this.name,
    required this.specialty,
    required this.price,
    required this.rating,
    this.reviewCount,
    required this.imageUrl,
    required this.distance,
    required this.bio,
    this.lat,
    this.lng,
  });

  factory TrainerProfileModel.fromJson(Map<String, dynamic> json) {
    final user = _object(json['user']);
    final source = user == null ? json : <String, dynamic>{...json, ...user};
    final profile =
        _object(json['trainerProfile']) ??
        _object(json['trainer_profile']) ??
        _object(source['trainerProfile']) ??
        _object(source['trainer_profile']) ??
        _object(source['profile']) ??
        const <String, dynamic>{};
    final location =
        _object(json['location']) ??
        _object(json['liveLocation']) ??
        _object(json['live_location']) ??
        _object(source['location']) ??
        _object(source['liveLocation']) ??
        _object(source['live_location']) ??
        _object(profile['location']) ??
        const <String, dynamic>{};

    final firstName = _readString(source, const ['firstName', 'first_name']);
    final lastName = _readString(source, const ['lastName', 'last_name']);
    final combinedName = [firstName, lastName]
        .where((value) => value != null && value.trim().isNotEmpty)
        .join(' ');
    final name =
        _readString(source, const ['name', 'fullName', 'full_name']) ??
        (combinedName.isEmpty ? null : combinedName) ??
        'Trainer';
    final priceValue =
        _readString(profile, const [
          'price',
          'pricePerSession',
          'price_per_session',
          'pricePerMember',
          'price_per_member',
        ]) ??
        _readString(source, const [
          'price',
          'pricePerSession',
          'price_per_session',
        ]);

    return TrainerProfileModel(
      id: _readString(source, const ['id', 'userId', 'user_id']),
      name: name,
      specialty:
          _readString(profile, const [
            'specialty',
            'expertise',
            'classesTaught',
            'classes_taught',
          ]) ??
          _readString(source, const [
            'specialty',
            'expertise',
            'classesTaught',
            'classes_taught',
          ]) ??
          'Fitness Trainer',
      price: _formatPrice(priceValue),
      rating:
          _readDouble(source, const ['rating', 'averageRating']) ??
          _readDouble(profile, const ['rating', 'averageRating']) ??
          0,
      reviewCount:
          _readInt(source, const ['reviewCount', 'review_count', 'reviews']) ??
          _readInt(profile, const ['reviewCount', 'review_count', 'reviews']),
      imageUrl:
          _readString(source, const [
            'image',
            'imageUrl',
            'image_url',
            'profileImage',
            'profile_image',
            'avatar',
          ]) ??
          _readString(profile, const [
            'image',
            'imageUrl',
            'image_url',
            'profileImage',
            'profile_image',
            'avatar',
          ]) ??
          '',
      distance: _formatDistance(
        _readDouble(source, const [
              'distance',
              'distanceKm',
              'distance_km',
            ]) ??
            _readDouble(profile, const [
              'distance',
              'distanceKm',
              'distance_km',
            ]),
      ),
      bio:
          _readString(profile, const ['bio', 'description']) ??
          _readString(source, const ['bio', 'description']) ??
          '',
      lat:
          _readDouble(location, const ['lat', 'latitude']) ??
          _readDouble(source, const ['lat', 'latitude']),
      lng:
          _readDouble(location, const ['lng', 'longitude']) ??
          _readDouble(source, const ['lng', 'longitude']),
    );
  }

  Map<String, dynamic> toUiMap() {
    return {
      'id': id,
      'name': name,
      'expertise': specialty,
      'rating': rating,
      'price': price,
      'imageUrl': imageUrl,
      'distance': distance,
      'reviewCount': reviewCount,
      'bio': bio,
      'lat': lat,
      'lng': lng,
    };
  }

  static String _formatPrice(String? value) {
    if (value == null || value.isEmpty) return 'Price unavailable';
    if (value.contains('/')) return value;
    if (value.startsWith(r'$')) return '$value/session';
    return '$value/session';
  }

  static String _formatDistance(double? value) {
    if (value == null) return '';
    if (value < 1) return '${(value * 1000).round()}m';
    return '${value.toStringAsFixed(value >= 10 ? 0 : 1)}km';
  }

  static Map<String, dynamic>? _object(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }

    return null;
  }

  static String? _readString(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) continue;

      final text = value.toString().trim();
      if (text.isNotEmpty && text.toLowerCase() != 'null') {
        return text;
      }
    }

    return null;
  }

  static int? _readInt(Map<String, dynamic> json, List<String> keys) {
    final value = _readString(json, keys);
    if (value == null) return null;

    return int.tryParse(value) ?? double.tryParse(value)?.round();
  }

  static double? _readDouble(Map<String, dynamic> json, List<String> keys) {
    final value = _readString(json, keys);
    if (value == null) return null;

    return double.tryParse(value);
  }
}
