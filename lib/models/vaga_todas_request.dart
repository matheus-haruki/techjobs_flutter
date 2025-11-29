class ObterTodasVagasRequest {
  final double? salarioInicio;
  final double? salarioFim;
  final String? termoBusca;

  ObterTodasVagasRequest({
    this.salarioInicio,
    this.salarioFim,
    this.termoBusca,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (salarioInicio != null && salarioInicio! > 0) {
      map["salarioInicio"] = salarioInicio;
    }

    if (salarioFim != null && salarioFim! > 0) {
      map["salarioFim"] = salarioFim;
    }

    if (termoBusca != null && termoBusca!.isNotEmpty) {
      map["termoBusca"] = termoBusca;
    }

    return map;
  }
}
