import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BookingProvider with ChangeNotifier {
  int _completedCleanings = 0;
    int get completedCleanings => _completedCleanings;

      BookingProvider() {
          _loadStats();
            }

              void _loadStats() async {
                  final box = await Hive.openBox('stats');
                      _completedCleanings = box.get('count', defaultValue: 0) as int;
                          notifyListeners();
                            }

                              void addCleaning() async {
                                  _completedCleanings++;
                                      final box = await Hive.openBox('stats');
                                          await box.put('count', _completedCleanings);
                                              notifyListeners();
                                                }

                                                  double calculatePrice(String type, List<String> options) {
                                                      double base = 0;
                                                          if (type.contains("Studio")) base = 60;
                                                              else if (type.contains("T2")) base = 75;
                                                                  else if (type.contains("T3")) base = 100;
                                                                      else if (type.contains("Maison")) base = 140;
                                                                          final double optionsCost = options.length * 15.0;
                                                                              double total = base + optionsCost;
                                                                                  if (_completedCleanings >= 8) total *= 0.8;
                                                                                      else if (_completedCleanings >= 4) total *= 0.9;
                                                                                          return total;
                                                                                            }
                                                                                            }