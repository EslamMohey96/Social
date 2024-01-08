class userModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String background;
  late String bio;
  late bool isEmailVerified;


  userModel({
    required this.email,
    required this.uId,
    required this.name,
    required this.phone,
    required this.image,
    required this.background,
    required this.bio,
    required this.isEmailVerified,    
  });

  userModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    image = json?['image'];
    background = json?['background'];
    bio = json?['bio'];
    uId = json?['uId'];
    isEmailVerified = json?['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'background': background,
      'bio': bio,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}
