import 'dart:convert';

class Queue {
  String method;
  String url;
  int id;
  String data;
  String status;
  Queue({
    required this.method,
    required this.url,
    required this.id,
    required this.data,
    required this.status,
  });

  Queue copyWith({
    String? method,
    String? url,
    int? id,
    String? data,
    String? status,
  }) {
    return Queue(
      method: method ?? this.method,
      url: url ?? this.url,
      id: id ?? this.id,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'method': method,
      'url': url,
      'id': id,
      'data': data,
      'status': status,
    };
  }

  factory Queue.fromMap(Map<String, dynamic> map) {
    return Queue(
      method: map['method'] ?? '',
      url: map['url'] ?? '',
      id: map['id'] ?? 0,
      data: map['data'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Queue.fromJson(String source) => Queue.fromMap(json.decode(source));

  static String encode(List<Queue> q) =>
      jsonEncode(q.map<Map<String, dynamic>>((item) => item.toMap()).toList());

  static List<Queue> decode(String queueLogs) =>
      (jsonDecode(queueLogs) as List<dynamic>)
          .map<Queue>((item) => Queue.fromMap(item))
          .toList();

  @override
  String toString() =>
      'Queue(method: $method,url: $url, id: $id,data: $data, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Queue &&
        other.method == method &&
        other.url == url &&
        other.id == id &&
        other.data == data &&
        other.status == status;
  }

  @override
  int get hashCode =>
      method.hashCode ^
      url.hashCode ^
      id.hashCode ^
      data.hashCode ^
      status.hashCode;
}
