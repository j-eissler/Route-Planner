class Prediction {
  final String description;
  final String placeId;

  Prediction(this.description, this.placeId);

  Prediction.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        placeId = json['place_id'];

  Map<String, dynamic> toJson() =>
      {'description': description, 'placeId': placeId};
}
