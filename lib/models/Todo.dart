import 'dart:convert';

class Todo {
  String method;
  String data;
  String status;
  Todo({
    required this.method,
    required this.data,
    required this.status,
  });

  Todo copyWith({
    String? method,
    String? data,
    String? status,
  }) {
    return Todo(
      method: method ?? this.method,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'method': method,
      'data': data,
      'status': status,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      method: map['method'] ?? '',
      data: map['data'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() => 'Todo(method: $method, data: $data, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.method == method &&
        other.data == data &&
        other.status == status;
  }

  @override
  int get hashCode => method.hashCode ^ data.hashCode ^ status.hashCode;
}
