class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String idNumber;
  final String password;
  final String role;
  final String image;
  final bool isSelected;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
    required this.password,
    required this.idNumber,
    required this.role,
    this.isSelected = false,
  });

  // Create a User from JSON
  factory User.fromJson(String id,Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      idNumber: json['idNumber'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      isSelected: json['isSelected'] ?? false,
    );
  }

  // Convert a User to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'idNumber': idNumber,
      'password' : password,
      'role' : role,
      'image': image,
      'isSelected':isSelected
    };
  }

  // 👇 Add this
  User copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? idNumber,
    String? password,
    String? role,
    String? image,
    bool? isSelected,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      idNumber: idNumber ?? this.idNumber,
      password: password ?? this.password,
      role: role ?? this.role,
      image: image ?? this.image,
      isSelected: isSelected ?? this.isSelected,
    );
  }

}

