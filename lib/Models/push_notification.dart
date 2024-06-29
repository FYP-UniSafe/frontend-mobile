class PushNotification{

  String? title;
  String? body;

  PushNotification({this.title, this.body});


  factory PushNotification.fromJson(Map<String,dynamic> json){
    return PushNotification(
      title: json['title'],
      body: json['body'],
    );
  }



}