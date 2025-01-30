import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MqttService {
  final String broker = 'broker.hivemq.com';
  final int port = 1883;
  final String clientIdentifier = 'flutter_client';
  final String topic = 'app_antichute/alerte';
// Remplacez par votre topic
  MqttServerClient? client;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  MqttService() {
    client = MqttServerClient(broker, clientIdentifier);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    flutterLocalNotificationsPlugin?.initialize(initSettings);
  }

  Future<void> connect() async {
    client?.logging(on: true);
    client?.keepAlivePeriod = 20;
    client?.onDisconnected = _onDisconnected;
    client?.onConnected = _onConnected;
    client?.onSubscribed = _onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client?.connectionMessage = connMessage;

    try {
      await client?.connect();
    } catch (e) {
      print('Exception: $e');
      client?.disconnect();
    }

    if (client?.connectionStatus?.state == MqttConnectionState.connected) {
      print('Connecté au broker MQTT');
      client?.subscribe(topic, MqttQos.atLeastOnce);
      client?.updates?.listen(_onMessage);
    } else {
      print('Échec de la connexion');
      client?.disconnect();
    }
  }

  void _onDisconnected() {
    print('Déconnecté du broker MQTT');
  }

  void _onConnected() {
    print('Connecté au broker MQTT');
  }

  void _onSubscribed(String? topic) {
    print('Souscrit au topic: $topic');
  }

  void _onMessage(List<MqttReceivedMessage<MqttMessage?>>? event) {
    final recMessage = event?[0].payload as MqttPublishMessage;
    final payload =
    MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);
    print('Message reçu: $payload de ${event?[0].topic}');

    if (payload == 'chute_detectee') {
      _handleFallDetection();
    }
  }

  void _handleFallDetection() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 1000);
    }
    const androidDetails = AndroidNotificationDetails(
        'chute_channel', 'Détection de Chute',
        channelDescription: 'Notification lors de la détection d\'une chute',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const notificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin?.show(
        0, 'Alerte', 'Une chute a été détectée', notificationDetails,
        payload: 'chute_payload');
  }

  void disconnect() {
    client?.disconnect();
  }
}
