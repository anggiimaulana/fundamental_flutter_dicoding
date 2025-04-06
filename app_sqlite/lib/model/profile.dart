class Profile {
  final int? id;
  final String name;
  final String email;
  final String phoneNumber;
  final bool? maritalStatus;

  Profile({
    this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.maritalStatus,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'marital_status': (maritalStatus ?? false) ? 1 : 0,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      maritalStatus: (json['marital_status'] ?? 0) == 1,
    );
  }
}
