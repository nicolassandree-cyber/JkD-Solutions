import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import '../theme/app_theme.dart';
import '../models/booking.dart';

class P2PScreen extends StatefulWidget {
  final Booking? bookingToSend;

  const P2PScreen({Key? key, this.bookingToSend}) : super(key: key);

  @override
  State<P2PScreen> createState() => _P2PScreenState();
}

class _P2PScreenState extends State<P2PScreen> {
  final Strategy strategy = Strategy.P2P_STAR;
  String status = "Inactif";
  List<String> logs = [];

  void _addLog(String msg) => setState(() => logs.insert(0, msg));

  // Mode Client : envoie la demande
  void startAdvertising() async {
    try {
      // FIX: suppression de `bool a =` (variable inutilisée)
      await Nearby().startAdvertising(
        "Client_JkD",
        strategy,
        onConnectionInitiated: (id, info) => onConnectionInit(id, info),
        onConnectionResult: (id, s) => _addLog("Connexion: $s"),
        onDisconnected: (id) => _addLog("Déconnecté"),
      );

      // Envoi du booking dès qu'une connexion est établie
      setState(() => status = "En attente d'un prestataire...");
    } catch (e) {
      _addLog("Erreur: $e");
    }
  }

  // Mode Prestataire : reçoit la demande
  void startDiscovery() async {
    try {
      // FIX: suppression de `bool a =` (variable inutilisée)
      await Nearby().startDiscovery(
        "Admin_JkD",
        strategy,
        onEndpointFound: (id, name, serviceId) {
          Nearby().requestConnection(
            "Admin_JkD",
            id,
            onConnectionInitiated: (id, info) => onConnectionInit(id, info),
            onConnectionResult: (id, s) => _addLog("Connecté au client"),
            onDisconnected: (id) => _addLog("Déconnecté"),
          );
        },
        onEndpointLost: (id) => _addLog("Perdu"),
      );
      setState(() => status = "Recherche de clients...");
    } catch (e) {
      _addLog("Erreur: $e");
    }
  }

  void onConnectionInit(String id, ConnectionInfo info) {
    Nearby().acceptConnection(
      id,
      onPayloadReceived: (endpointId, payload) {
        if (payload.type == PayloadType.BYTES && payload.bytes != null) {
          final String data = String.fromCharCodes(payload.bytes!);
          _addLog("Réservation reçue !");
          _showBookingDialog(data);
        }
      },
    );

    // Si on est côté client, on envoie le booking après acceptation
    if (widget.bookingToSend != null) {
      final bytes = widget.bookingToSend!.toJson().codeUnits;
      Nearby().sendBytesPayload(id, Uint8List.fromList(bytes));
      _addLog("Demande envoyée !");
    }
  }

  // FIX: méthode complète (était vide) + typo JkDColors → JkdColors
  void _showBookingDialog(String data) {
    final Booking booking = Booking.fromJson(data);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: JkdColors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text(
          "Nouvelle demande",
          // FIX: JkDColors → JkdColors (typo critique)
          style: TextStyle(color: JkdColors.gold, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoTile("Client", booking.clientName),
            _infoTile("Téléphone", booking.phone),
            _infoTile("Adresse", booking.address),
            _infoTile("Service", booking.serviceType),
            _infoTile("Options", booking.options.isEmpty ? "Aucune" : booking.options.join(", ")),
            _infoTile("Prix", "${booking.totalPrice.toStringAsFixed(2)} €"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addLog("Réservation refusée pour ${booking.clientName}");
            },
            child: const Text("REFUSER", style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: JkdColors.gold),
            onPressed: () {
              Navigator.pop(context);
              _addLog("Réservation acceptée pour ${booking.clientName}");
            },
            child: const Text(
              "ACCEPTER",
              // FIX: JkDColors → JkdColors
              style: TextStyle(color: JkdColors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label : ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: JkdColors.gold,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: JkdColors.offWhite),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Connexion Directe")),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: JkdColors.gold.withOpacity(0.1),
            child: Text(
              "Statut : $status",
              style: const TextStyle(
                color: JkdColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: logs.isEmpty
                ? const Center(
                    child: Text(
                      "Aucune activité",
                      style: TextStyle(color: Colors.white38),
                    ),
                  )
                : ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, i) => ListTile(
                      title: Text(
                        logs[i],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: startAdvertising,
                    child: const Text("ENVOYER (Client)"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: startDiscovery,
                    child: const Text("RECEVOIR (Pro)"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
