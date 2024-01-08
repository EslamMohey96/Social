import 'package:flutter/material.dart';
import 'package:social_app/models/userModel.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';

String baseURL = 'https://student.valuxapps.com/api/';
Map<String, dynamic> headers = {
  'Content-Type': 'application/json',
};
String urlMethod = 'api/users';
Map<String, dynamic> users = {
  'page': 2,
};

String uIdConst = 'NGheb2dZAoWw6faqd56zZOrbgbP2';
String lang = 'en';
List<GlobalObjectKey<FormState>> formKeyList =
    List.generate(10, (index) => GlobalObjectKey<FormState>(index));


late userModel user_model;