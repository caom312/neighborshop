import 'package:firebase_messaging/firebase_messaging.dart';

class recibiendoMensajes {
  FirebaseMessaging mensaje = FirebaseMessaging.instance;

  notificaciones (){
    mensaje.requestPermission();
    mensaje.getToken().then((token) {
      print('----------TOKEN---------');
      print(token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //aplicacion esta abierta
    });
    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // aplicacion esta en segundo plano
    });
    
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async { // aplicacion esta cerrada

    });
  }
}