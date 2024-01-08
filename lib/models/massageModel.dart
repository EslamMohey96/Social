class massageModel {
  late String date;
  late String sender;
  late String receiver;
  late String text;



  massageModel({
    required this.date,
    required this.sender,
    required this.receiver,
    required this.text,  
  });

  massageModel.fromJson(Map<String, dynamic>? json) {
    date = json?['date'];
    sender = json?['sender'];
    receiver = json?['receiver'];
    text = json?['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'sender': sender,
      'receiver': receiver,
      'text': text,
    };
  }
}
