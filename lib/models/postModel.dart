class postModel {
  late String name;
  late String uId;
  late String image;
  late String postText;
  late String postImage;
  late String date;



  postModel({
    required this.uId,
    required this.name,
    required this.image,
    required this.postText,
    required this.postImage,
    required this.date,
  });

  postModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    postText = json?['postText'];
    postImage = json?['postImage'];
    image = json?['image'];
    uId = json?['uId'];
    date = json?['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'postText': postText,
      'image': image,
      'uId': uId,
      'date': date,
    };
  }
}
