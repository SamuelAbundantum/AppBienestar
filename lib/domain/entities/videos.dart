class Video {
  final int id;
  final String nombre;
  final String url;
  final String descripcion;
  final String code;

  Video({
    required this.id,
    required this.nombre,
    required this.url,
    required this.descripcion,
    required this.code,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      nombre: json['nombre'],
      url: json['url'],
      descripcion: json['descripcion'],
      code: json['code'],
    );
  }
}