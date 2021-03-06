import 'package:flutter/material.dart';

import 'dart:collection';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutterinfrench/models/article_model.dart';

class ArticleController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ArticleController() {
    getArticles();
  }

  Future<List<ArticleModel>> getArticles() async {
    QuerySnapshot _dataFirestore = await _firestore
        .collection("articles")
        .orderBy("date", descending: true)
        .get();

    List<ArticleModel> _articleData = [];

    _dataFirestore.docs.forEach((article) {
      final _temp = ArticleModel(
          title: article.get("name"),
          description: article.get("description"),
          date: article.get("date"),
          imageUrl: article.get("preview"));
      if (_temp.date == null) {
        print("c'est null");
      }
      if (_temp.date != null &&
          _temp.title != null &&
          _temp.description != null &&
          _temp.imageUrl != null) {
        if (_temp.date.isNotEmpty &&
            _temp.description.isNotEmpty &&
            _temp.imageUrl.isNotEmpty &&
            _temp.title.isNotEmpty) {
          return _articleData.add(_temp);
        }
      }
    });
    return UnmodifiableListView(_articleData);
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Erreur, impossible de lancer l'url";
    }
  }

  Future<void> refreshArticles() async {
    await Future.delayed(Duration(
        seconds:
            3)); // evite que l'utilisateur de saturer la bdd en rafraichissant sans arret
    await getArticles();
    notifyListeners(); // a utuliser si stateLess qui perment de notifier a la screen que le contenue a changé
  }
}
