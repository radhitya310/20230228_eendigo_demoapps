class LivenessModel {
  String datetime;
  String error;
  List<ResultModel> result;
  String status;

  LivenessModel({
    required this.datetime,
    required this.error,
    required this.result,
    required this.status,
  });

  factory LivenessModel.fromJson(Map<String, dynamic> json) {
    return LivenessModel(
      datetime: json['datetime'],
      error: json['error'],
      result: (json['result'] as List<dynamic>).map((result) => ResultModel.fromJson(result)).toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'error': error,
      'result': result.map((result) => result.toJson()).toList(),
      'status': status,
    };
  }
}

class ResultModel {
  FaceLivenessModel faceLiveness;

  ResultModel({
    required this.faceLiveness,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      faceLiveness: FaceLivenessModel.fromJson(json['face_liveness']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'face_liveness': faceLiveness.toJson(),
    };
  }
}

class FaceLivenessModel {
  String live;
  double score;

  FaceLivenessModel({
    required this.live,
    required this.score,
  });

  factory FaceLivenessModel.fromJson(Map<String, dynamic> json) {
    return FaceLivenessModel(
      live: json['live'],
      score: double.parse(json['score']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'live': live,
      'score': score.toString(),
    };
  }
}