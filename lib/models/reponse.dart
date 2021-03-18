class Reponse {
  final id;
  final String? createBy;
  final int? createAt;
  final String? artiste;
  final String? titre;
  Reponse({this.id, this.createBy, this.createAt, this.artiste, this.titre});
  List<String> reaction = [];
  bool? isThat;
}
