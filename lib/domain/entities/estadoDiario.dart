enum ComoEstasHoy { muyMal, mal, bien, muyBien }
enum ComoTeSientes { enfadado, preocupado, triste, frustrado, noSeleccionado }
enum Area {
  alimentacionNutricion,
  crecimientoPersonal,
  cuerpoFisicoEnergiaVital,
  descansoSueno,
  dinero,
  espiritualidadFilosofia,
  familia,
  ocupacion,
  pareja,
  redesSociales,
  salud,
  sexualidadGeneral
}

class EstadoDiario {
  int id;
  ComoEstasHoy comoEstasHoy;
  ComoTeSientes comoTeSientes;
  Area area;
  String texto;
  String foto;
  DateTime fecha;

  EstadoDiario({
    required this.id,
    required this.comoEstasHoy,
    required this.comoTeSientes,
    required this.area,
    this.texto = '',
    this.foto = '',
    required this.fecha,
  });

  Map<String, dynamic> toMap(){
    return {
       'id': id,'comoEstasHoy': comoEstasHoy.toString(), 'comoTeSientes': comoTeSientes.toString(), 'area': area.toString(), 'texto': texto, 'foto': foto, 'fecha': fecha.toString(),
    };
  }
  }