import 'package:news_webapp/models/category_model.dart';

List<CategoryModel> getCategory() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = CategoryModel();
//
  categoryModel.imageUrl =
      'https://images.pexels.com/photos/1707640/pexels-photo-1707640.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  categoryModel.categoryName = 'Street Art';
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  //

  categoryModel.imageUrl =
      'https://images.pexels.com/photos/2608804/pexels-photo-2608804.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  categoryModel.categoryName = 'Wild Life';
  category.add(categoryModel);
  categoryModel = new CategoryModel();
//
  categoryModel.imageUrl =
      'https://images.pexels.com/photos/3293148/pexels-photo-3293148.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  categoryModel.categoryName = 'Nature';
  category.add(categoryModel);
  categoryModel = new CategoryModel();
//
  categoryModel.imageUrl =
      'https://images.pexels.com/photos/2393821/pexels-photo-2393821.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
  categoryModel.categoryName = 'Bikes';
  category.add(categoryModel);
  categoryModel = new CategoryModel();
  //
  categoryModel.imageUrl =
      'https://images.pexels.com/photos/1571783/pexels-photo-1571783.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';
  categoryModel.categoryName = 'Cars';
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}
