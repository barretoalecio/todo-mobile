class TaskModel {
  String _id;
  String _title;
  String _description;
  bool _complete;

  TaskModel({String id, String title="NO TITLE", String description="NO DESCRIPTION", bool complete = false}) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._complete = complete;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get description => _description;
  set description(String description) => _description = description;
  bool get complete => _complete;
  set complete(bool complete) => _complete = complete;

  TaskModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['description'] = this._description;
    data['complete'] = this._complete;
    return data;
  }
}