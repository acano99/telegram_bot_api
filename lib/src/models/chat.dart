class Chat {
  final int id;

  Chat({required this.id});

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(id: json['id']);
}
