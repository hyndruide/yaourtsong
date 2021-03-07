class Message {
  final id;
  final String createBy;
  final int createAt;
  final String message;
  Message({this.id, this.createBy, this.createAt, this.message});
  List<String> reaction = [];
}
