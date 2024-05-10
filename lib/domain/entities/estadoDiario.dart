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
  ComoEstasHoy comoEstasHoy;
  ComoTeSientes comoTeSientes;
  Area area;
  String texto;
  String foto;
  DateTime fecha;

  EstadoDiario({
    required this.comoEstasHoy,
    required this.area,
    required this.fecha,
    required this.comoTeSientes,
    this.texto = '',
    this.foto = '',
  });


}
