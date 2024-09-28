import 'package:campus/api/apisfornews/categorymodel.dart';
import 'package:flutter/foundation.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryMd = new CategoryModel();

  // categoryMd.categoryName = "Education";
  // categoryMd.image = "assets/images/reviews/education.jpg";
  // categories.add(categoryMd);
  // categoryMd = new CategoryModel();
  // categoryMd.categoryName = "Techonology";
  // categoryMd.image = "assets/images/reviews/techonology.jpg";
  // categories.add(categoryMd);

  categoryMd = new CategoryModel();

  categoryMd.categoryName = "Business";
  categoryMd.image = "assets/images/reviews/innovation.png";
  categories.add(categoryMd);

  categoryMd = new CategoryModel();
  categoryMd.categoryName = "General";
  categoryMd.image = "assets/images/reviews/Universities.png";
  categories.add(categoryMd);

  categoryMd = new CategoryModel();
  categoryMd.categoryName = "Entertainment";
  categoryMd.image = "assets/images/reviews/skill0.jpg";
  categories.add(categoryMd);

  categoryMd = new CategoryModel();
  categoryMd.categoryName = "Health";
  categoryMd.image = "assets/images/reviews/research.jpg";
  categories.add(categoryMd);

  categoryMd = new CategoryModel();
  categoryMd.categoryName = "Sports";
  categoryMd.image = "assets/images/reviews/project.jpg";
  categories.add(categoryMd);

  return categories;
}
