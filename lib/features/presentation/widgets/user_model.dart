class UserModel {
  String? uid;
  String? namaLengkap;
  String? email;

  UserModel({
    this.uid,
    this.email,
    this.namaLengkap,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      namaLengkap: map['namaLengkap'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'namaLengkap': namaLengkap,
    };
  }
}
