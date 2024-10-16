import 'package:flutter/material.dart';
import 'class_of_model.dart';

class FavoritesModel with ChangeNotifier {
  // Listas de favoritos para cada categoria
  final List<Universidade> _favoriteUniversities = [];
  final List<Map<String, String>> _favoriteNews = [];
  final List<Vestibular> _favoriteVestibulares = [];

  // Getters para acessar os favoritos
  List<Universidade> get favoriteUniversities => _favoriteUniversities;
  List<Map<String, String>> get favoriteNews => _favoriteNews;
  List<Vestibular> get favoriteVestibulares => _favoriteVestibulares;

  // Métodos para adicionar favoritos
  void addUniversityFavorite(Universidade universidade) {
    if (!_favoriteUniversities.contains(universidade)) {
      _favoriteUniversities.add(universidade);
      notifyListeners();
    }
  }

  void addNewsFavorite(Map<String, String> news) {
    if (!_favoriteNews.contains(news)) {
      _favoriteNews.add(news);
      notifyListeners();
    }
  }

  void addVestibularFavorite(Vestibular vestibular) {
    if (!_favoriteVestibulares.contains(vestibular)) {
      _favoriteVestibulares.add(vestibular);
      notifyListeners();
    }
  }

  // Métodos para remover favoritos
  void removeUniversityFavorite(Universidade universidade) {
    if (_favoriteUniversities.contains(universidade)) {
      _favoriteUniversities.remove(universidade);
      notifyListeners();
    }
  }

  void removeNewsFavorite(Map<String, String> news) {
    if (_favoriteNews.contains(news)) {
      _favoriteNews.remove(news);
      notifyListeners();
    }
  }

  void removeVestibularFavorite(Vestibular vestibular) {
    if (_favoriteVestibulares.contains(vestibular)) {
      _favoriteVestibulares.remove(vestibular);
      notifyListeners();
    }
  }

  // Verificadores de favoritos
  bool isUniversityFavorite(Universidade universidade) {
    return _favoriteUniversities.contains(universidade);
  }

  bool isNewsFavorite(Map<String, String> news) {
    return _favoriteNews.contains(news);
  }

  bool isVestibularFavorite(Vestibular vestibular) {
    return _favoriteVestibulares.contains(vestibular);
  }
}
