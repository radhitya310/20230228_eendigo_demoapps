class FaceCompare {
  final String compare;
  final double similarity;
  final double threshold;

  FaceCompare({
    required this.compare,
    required this.similarity,
    required this.threshold,
  });

  factory FaceCompare.fromJson(Map<String, dynamic> json) {
    return FaceCompare(
      compare: json['compare'],
      similarity: double.parse(json['similarity']),
      threshold: double.parse(json['threshold']),
    );
  }
}

class FaceLiveness {
  final String live;
  final double score;

  FaceLiveness({
    required this.live,
    required this.score,
  });

  factory FaceLiveness.fromJson(Map<String, dynamic> json) {
    return FaceLiveness(
      live: json['live'],
      score: double.parse(json['score']),
    );
  }
}

class Result {
  final FaceCompare faceCompare;
  final FaceLiveness faceLiveness;

  Result({
    required this.faceCompare,
    required this.faceLiveness,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      faceCompare: FaceCompare.fromJson(json['face_compare']),
      faceLiveness: FaceLiveness.fromJson(json['face_liveness']),
    );
  }
}

class LivenessCompareModel {
  final String datetime;
  final String error;
  final List<Result> result;
  final String status;

  LivenessCompareModel({
    required this.datetime,
    required this.error,
    required this.result,
    required this.status,
  });

  factory LivenessCompareModel.fromJson(Map<String, dynamic> json) {
    final resultList = (json['result'] as List<dynamic>)
        .map((resultJson) => Result.fromJson(resultJson))
        .toList();

    return LivenessCompareModel(
      datetime: json['datetime'],
      error: json['error'],
      result: resultList,
      status: json['status'],
    );
  }
}
