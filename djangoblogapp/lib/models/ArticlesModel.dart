class ArticlesModel {
  final int id;
  final String title;
  final String content;
  final String category;
  final DateTime created_at;
  final DateTime modified_at;
  final int readTime;
  final String featured_image;
  final String slug;
  final int commentCount;

  ArticlesModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.featured_image,
    required this.created_at,
    required this.modified_at,
    required this.readTime,
    required this.slug,
    required this.commentCount,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      category: json['category']?['category_name']?.toString() ?? '',
      featured_image: json['featured_image']?.toString() ?? '',
      created_at: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      modified_at: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
      readTime: json['readTime'] ?? 0,
      slug: json['slug']?.toString() ?? '',
      commentCount: json['commentCount'] ?? 0,
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'image_url': featured_image,
      'created_at': created_at.toIso8601String(),
      'updated_at': modified_at.toIso8601String(),
      'readTime': readTime,
      'slug': slug,
      'commentCount': commentCount,
    };
  }

  // fromJsonList method convert json array list of ArticleModel
  static List<ArticlesModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ArticlesModel.fromJson(json)).toList();
  }

  // 👇 Add this getter
  int get readTimeMethod {
    final wordCount = content.trim().split(RegExp(r'\s+')).length;
    return (wordCount / 200).ceil(); // assuming 200 words per minute
  }
}

class Category {
  final int id;
  final String category_name;
  final String image;
  final String slug;

  Category({
    required this.id,
    required this.category_name,
    required this.slug,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      category_name: json['category_name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'category_name' : category_name,
      'slug' : slug,
      'image' : image,
    };
  }
  static List<Category> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}
