import 'package:TechJobs/models/candidato_vaga_model.dart';
import 'package:TechJobs/models/vagas_model.dart';

class VagaEmpresaResponse {
  final Vaga vaga;
  final List<CandidatoVagaDTO> aplicacoes;

  VagaEmpresaResponse({
    required this.vaga,
    required this.aplicacoes,
  });

  factory VagaEmpresaResponse.fromJson(Map<String, dynamic> json) {
    return VagaEmpresaResponse(
      vaga: Vaga.fromJson(json["vaga"]),
      aplicacoes: (json["aplicacoes"] as List)
          .map((item) => CandidatoVagaDTO.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vaga": vaga.toJson(),
      "aplicacoes": aplicacoes.map((a) => a.toJson()).toList(),
    };
  }
}