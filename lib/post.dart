import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  int? _userId;
  int? _id;
  String? _title;
  String? _body;

  int? get userId => _userId;
  int? get id => _id;
  String? get title => _title;
  String? get body => _body;

  Post({
      int? userId, 
      int? id, 
      String? title, 
      String? body}){
    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
}

  factory Post.fromJson(dynamic json) => _$PostFromJson(json);

  // Map<String, dynamic> toJson() {
  //   var map = <String, dynamic>{};
  //   map["userId"] = _userId;
  //   map["id"] = _id;
  //   map["title"] = _title;
  //   map["body"] = _body;
  //   return map;
  // }

}