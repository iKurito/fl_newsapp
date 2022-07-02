import 'package:fl_newsapp/src/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:fl_newsapp/src/models/news_model.dart';

const _urlNews = 'newsapi.org';
const _apiKey = '2907c2a61a224a77a76c1d02e2e6e59e';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology')
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }
    getArticlesByCategory(_selectedCategory);
  }
  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriasSeleccionada => categoryArticles[selectedCategory]!;

  Future getTopHeadlines() async {
    final url = Uri.https(
      _urlNews,
      '/v2/top-headlines',
      { 
        'apiKey': _apiKey,
        'country': 'br'
      }
    );
    final resp = await http.get(url);

    final newResponse = newsResponseFromJson(resp.body);
    
    headlines.addAll(newResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final url = Uri.https(
      _urlNews,
      '/v2/top-headlines',
      { 
        'apiKey': _apiKey,
        'country': 'br',
        'category': category
      }
    );
    final resp = await http.get(url);

    final newResponse = newsResponseFromJson(resp.body);
    
    categoryArticles[category]!.addAll(newResponse.articles);

    _isLoading = false;
    notifyListeners();
  }
}