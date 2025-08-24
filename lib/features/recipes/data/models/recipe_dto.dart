class RecipeDto {
  final String id;
  final String title;
  final String imageUrl;
  final String publisher;
  final int cookingTime;
  RecipeDto(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.cookingTime,
      required this.publisher});

  //! Chuyển từ JSON sang model
  factory RecipeDto.fromJson(Map<String, dynamic> json) => RecipeDto(
        id: json['id'] as String,
        title: json['title'] as String,
        imageUrl: json['image_url'] as String,
        cookingTime: json['cooking_time'] ?? 12,
        publisher: json['publisher'] as String,
      );

  //Ly do khong dùng mapper ở đây
//   RecipeDto nằm ở data layer (model cho API).
// Recipe (entity) nằm ở domain layer.
// Nếu em cho RecipeDto có method toEntity(), nghĩa là:
// Data layer biết về domain layer.
// Data layer bị phụ thuộc ngược vào domain → vi phạm “Dependency Rule”.
// Clean Architecture quy định: Domain không được phụ thuộc Data, mà Data phải phụ thuộc Domain.
// Tách riêng bằng extension giúp:

// RecipeDto chỉ lo parse JSON, không quan tâm domain.

// Mapping được viết riêng, không phá vỡ cấu trúc.

// RecipeDto trách nhiệm duy nhất: ánh xạ API <-> object.

// RecipeMapper trách nhiệm duy nhất: chuyển đổi sang Entity.
}
