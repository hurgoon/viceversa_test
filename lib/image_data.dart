class ImageData {
  final String galContentId;
  final String galContentTypeId;
  final String galTitle;
  final String galWebImageUrl;
  final String galCreatedtime;
  final String galModifiedtime;
  final String galPhotographyMonth;
  final String galPhotographyLocation;
  final String galPhotographer;
  final String galSearchKeyword;

  ImageData({
    required this.galContentId,
    required this.galContentTypeId,
    required this.galTitle,
    required this.galWebImageUrl,
    required this.galCreatedtime,
    required this.galModifiedtime,
    required this.galPhotographyMonth,
    required this.galPhotographyLocation,
    required this.galPhotographer,
    required this.galSearchKeyword,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      galContentId: json['galContentId'],
      galContentTypeId: json['galContentTypeId'],
      galTitle: json['galTitle'],
      galWebImageUrl: json['galWebImageUrl'],
      galCreatedtime: json['galCreatedtime'],
      galModifiedtime: json['galModifiedtime'],
      galPhotographyMonth: json['galPhotographyMonth'],
      galPhotographyLocation: json['galPhotographyLocation'],
      galPhotographer: json['galPhotographer'],
      galSearchKeyword: json['galSearchKeyword'],
    );
  }
}
