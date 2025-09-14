import 'package:cloud_firestore/cloud_firestore.dart';

class Note{
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String total;

 Note({
   required this.id,
   required this.title,
   required this.content,
   required this.date,
   required this.total,
});

Map<String,dynamic>toJson(){
  return{
    'title': title,
    'content': content,
    'date': date,
    'monthly': total,
  };
}

  factory Note.fromJson(String id, Map<String, dynamic> json) {
    return Note(
      id: id,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: (json['date'] is Timestamp)
          ? (json['date'] as Timestamp).toDate()
          : (json['date'] is String)
          ? DateTime.tryParse(json['date']) ?? DateTime.now()
          : DateTime.now(),
      total: json['monthly'] ?? '0',
    );
  }

}