class DashboardCandidatoResponse {
  final int vagasDisponiveis;
  final int vagasAplicadas;
  final int processosAtivos;

  DashboardCandidatoResponse({
    required this.vagasDisponiveis,
    required this.vagasAplicadas,
    required this.processosAtivos,
  });

  factory DashboardCandidatoResponse.fromJson(Map<String, dynamic> json) {
    return DashboardCandidatoResponse(
      vagasDisponiveis: json['vagasDisponiveis'] ?? 0,
      vagasAplicadas: json['vagasAplicadas'] ?? 0,
      processosAtivos: json['processosAtivos'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vagasDisponiveis": vagasDisponiveis,
      "vagasAplicadas": vagasAplicadas,
      "processosAtivos": processosAtivos,
    };
  }
}
