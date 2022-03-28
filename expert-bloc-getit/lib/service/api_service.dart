import 'package:fundamental_recap/model/dog_breed.dart';
import 'package:fundamental_recap/model/dog_breed_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<DogBreed> listDogBreed() async {
    final response = await http.get(
      Uri.parse("https://dog.ceo/api/breeds/list/all"),
    );
    if (response.statusCode == 200) {
      return DogBreed.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list of dog breeds');
    }
  }

  Future<DogBreedDetail> dogBreed(String breed) async {
    final response = await http.get(
      Uri.parse("https://dog.ceo/api/breed/$breed/images/random"),
    );
    if (response.statusCode == 200) {
      return DogBreedDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load image of dog $breed');
    }
  }
}
