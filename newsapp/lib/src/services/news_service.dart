import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';

final _URL_NEWES = 'https://newsapi.org/v2';
final _APIKEY = '21eb11a6c28c4669b313b8ec339dabdd';

class NewsService with ChangeNotifier {
  List<Article> headline = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticle = {};

  NewsService() {
    this.getTopHeadline();
    categories.forEach((item) {
      this.categoryArticle[item.name] = List();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String value) {
    this._selectedCategory = value;
    this.getArticleByCategory(selectedCategory);
    notifyListeners();
  }
  List<Article> get getArticuloCategoriaSeleccionada => this.categoryArticle[this.selectedCategory];

  getTopHeadline() async {
    final url = '$_URL_NEWES/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.headline.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticleByCategory(String category) async {
    if (this.categoryArticle[category].length > 0) {
      return this.categoryArticle[category];
    }
    final url =
        '$_URL_NEWES/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticle[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}
