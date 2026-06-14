import 'dart:convert';

class Booking {
  final String id;
    final String clientName;
      final String phone;
        final String address;
          final String serviceType;
            final DateTime date;
              final List<String> options;
                final double totalPrice;
                  String status;

                    Booking({
                        required this.id,
                            required this.clientName,
                                required this.phone,
                                    required this.address,
                                        required this.serviceType,
                                            required this.date,
                                                required this.options,
                                                    required this.totalPrice,
                                                        this.status = "En attente",
                                                          });

                                                            Map<String, dynamic> toMap() => {
                                                                'id': id,
                                                                    'clientName': clientName,
                                                                        'phone': phone,
                                                                            'address': address,
                                                                                'serviceType': serviceType,
                                                                                    'date': date.toIso8601String(),
                                                                                        'options': options,
                                                                                            'totalPrice': totalPrice.toDouble(),
                                                                                                'status': status,
                                                                                                  };

                                                                                                    String toJson() => jsonEncode(toMap());

                                                                                                      factory Booking.fromJson(String source) {
                                                                                                          final data = jsonDecode(source);
                                                                                                              return Booking(
                                                                                                                    id: data['id'] as String,
                                                                                                                          clientName: data['clientName'] as String,
                                                                                                                                phone: data['phone'] as String,
                                                                                                                                      address: data['address'] as String,
                                                                                                                                            serviceType: data['serviceType'] as String,
                                                                                                                                                  date: DateTime.parse(data['date'] as String),
                                                                                                                                                        options: List<String>.from(data['options'] as List),
                                                                                                                                                              totalPrice: (data['totalPrice'] as num).toDouble(),
                                                                                                                                                                    status: data['status'] as String,
                                                                                                                                                                        );
                                                                                                                                                                          }
                                                                                                                                                                          } 