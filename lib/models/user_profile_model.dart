class UserProfileModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? gender;
  final String? role;
  final String? imageUrl;
  final String? state;
  final String? location;
  final String? bio;

  const UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.gender,
    this.role,
    this.imageUrl,
    this.state,
    this.location,
    this.bio,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final data = _object(json['data']) ?? json;
    final source = _object(data['user']) ?? data;
    final profile =
        _object(source['profile']) ??
        _object(source['trainerProfile']) ??
        _object(source['trainer_profile']) ??
        const <String, dynamic>{};

    final firstName = _readString(source, const ['firstName', 'first_name']);
    final lastName = _readString(source, const ['lastName', 'last_name']);
    final combinedName = [firstName, lastName]
        .where((value) => value != null && value.trim().isNotEmpty)
        .join(' ');

    return UserProfileModel(
      id: _readString(source, const ['id', 'userId', 'user_id']),
      firstName: firstName,
      lastName: lastName,
      fullName:
          _readString(source, const ['name', 'fullName', 'full_name']) ??
          (combinedName.isEmpty ? null : combinedName),
      email: _readString(source, const ['email']),
      phoneNumber: _readString(source, const [
        'phoneNumber',
        'phone_number',
        'phone',
      ]),
      gender: _readString(source, const ['gender']),
      role: _readString(source, const ['role']),
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
          ]),
      state:
          _readString(source, const ['state']) ??
          _readString(profile, const ['state']),
      location:
          _readString(source, const ['location', 'address']) ??
          _readString(profile, const ['location', 'address']),
      bio:
          _readString(source, const ['bio', 'description']) ??
          _readString(profile, const ['bio', 'description']),
    );
  }

  String get displayName {
    final value = fullName?.trim();
    if (value != null && value.isNotEmpty) return value;

    final combinedName = [firstName, lastName]
        .where((value) => value != null && value.trim().isNotEmpty)
        .join(' ');
    if (combinedName.isNotEmpty) return combinedName;

    final emailValue = email?.trim();
    if (emailValue != null && emailValue.isNotEmpty) {
      return emailValue.split('@').first;
    }

    return 'Trainer';
  }

  String get displayLocation {
    final locationValue = location?.trim();
    if (locationValue != null && locationValue.isNotEmpty) {
      return locationValue;
    }

    final stateValue = state?.trim();
    if (stateValue != null && stateValue.isNotEmpty) {
      return stateValue;
    }

    return 'Location not added';
  }

  static Map<String, dynamic>? _object(dynamic value) {
    if (value is Map<String, dynamic>) return value;
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
}
