class Song {
  final id;
  final String? createBy;
  final int? createAt;
  final String? songUrl;
  final String? style;
  final String? where;
  final String? comment;
  Song(
      {this.id,
      this.createBy,
      this.createAt,
      this.songUrl,
      this.style,
      this.where,
      this.comment});
  int heard = 0;
  int note = 0;
}
