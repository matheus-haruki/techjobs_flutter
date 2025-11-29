class DashboardEmpresaResponse {
  final int vagasDisponiveis;
  final int candidatos;
  final int aprovacoes;

  DashboardEmpresaResponse({
    required this.vagasDisponiveis,
    required this.candidatos,
    required this.aprovacoes,
  });

  factory DashboardEmpresaResponse.fromJson(Map<String, dynamic> json) {
    return DashboardEmpresaResponse(
      vagasDisponiveis: json['vagasDisponiveis'] ?? 0,
      candidatos: json['candidatos'] ?? 0,
      aprovacoes: json['aprovacoes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vagasDisponiveis": vagasDisponiveis,
      "candidatos": candidatos,
      "aprovacoes": aprovacoes,
    };
  }
}
