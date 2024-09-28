import 'dart:developer';

import 'package:googleapis_auth/auth_io.dart';

class NotificationAccessToken {
  static String? _token;

  //to generate token only once for an app run
  static Future<String?> get getToken async =>
      _token ?? await _getAccessToken();

  // to get admin bearer token
  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        // To get Admin Json File: Go to Firebase > Project Settings > Service Accounts
        // > Click on 'Generate new private key' Btn & Json file will be downloaded

        // Paste Your Generated Json File Content
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "campusadel-2980a",
          "private_key_id": "d02d7fdc2151ecce7e6501f4de686a300a1aa834",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC+5Eh26MPhCom4\ngwDqUvqj09klVbig3TmaPsX3RQOn1oY9I+URP+hGZbnZz+7c6w8SufZWjn1iPJTy\nSzMlzqFqnmJViptWxRqsWcvEh3rg1hdQFRd29lqpFSrFGPVmE6SxBrHMuLf7/d0P\nuu4IIRtVa3fX4vbgT6I00GG5tk9hMdNQ6IKZwxydeBepVx0hrKkyvJprugTdOGHx\nnc0yv8gP0bnvIDGY9ibcMka9bNbx+6YpSqnss8DCxHJDiGS/e68Qi5xURCFw0369\nSiiu81Fh4fB5o3yLPZIi1e/AWLG6sPXa6ZWaxvvK5KSFyCzoxtnh5JzoPdaJGUvH\np/s4oTy3AgMBAAECggEAUtD2UURFqu3n9vk63e43F/lSVVy9t2iS04TVXSP/ZILx\nBTh76kJoEpaSjVklH4oJJY4xPbce1Y5D7mRKoeXl6LwjHEqAfyIPIuPoP/CpEj8/\nqPoljnJtvbpVrmHYITt3cWfenlsrUvN9wxPNrhAy7BmuSiaJBaL20+Pt6eSaxqbW\na5Aht526v2B51qIDeCXgiUduJVti+px2wNlw6SUCuNNgen6sP+IQRjObeY4u2J62\n0939s9lXliImvNG00TSpM9Xf16ORsmey2DhtbuAhAF6SpbP13ERYqfrMVSrERu4Y\nfIzYtt/cvTfaha7YbeairmKD2liJz8QgLAzg4gBH9QKBgQD5+3bArO/+pQBGR10s\nCcMqV+XeXG3SQ4cyf02JegorMPL5BMFRZAIv/n3OmaLonVgMwT9J903RwQ+Xnv1Q\n/Eq6LuKKwfjNIMrz94HQzDDpwK4cnZXX0WoSK+oJyU8+NEgamDtBfRAQll8ITKKB\nCZdarBTolEqkw1nj+urGcRlTKwKBgQDDfKs7Cq6DcA8J+ZnxSj/FyQQguntTLjk4\nXdCOnBUmCkftsmyb30UrAlC96JwqZ9bN4TW++hffFW1WlH6Z6kNqRv4nG78saHme\nSfy2YLMAHP2B8x/gI8kJwD8RYtMlPWmfYADXYnwWSHSYbqvbs8J8xkVPRU+ROlDR\nLIZ9pMLmpQKBgQDsYlGFGQNIdJax3kHIpuKaY8vGXPisX5a0tZSIb5K2DO91cn2r\njTpUT/5/IuDdvgvI4+QI+YXo1vr7kShRMIEpVbR7Kbkvn9bKpD1pR+zo3X7HKGzN\nTAVVcZk579azJ5UXMOS3pJ9QUCFFI9J22q742shatf9vlhqmblsbk08zSQKBgG1I\nW30FKqwF0BJ2e829AUuzZWBaf6jvlUNihr3CmbwLUUybS0YUGdnCUJrp16uJIzcy\n6FXb/85Rby9Qkjm/EXLvPxNj2oqb2SlZGTJneoncqwejf7VQrAmMdHVmtr0ByPM0\nuyOtRcs7NBsm+2I16srQGF0JVULNw/I7nu/MVLyVAoGAGud/pVzavsxLBaJVn44v\n8g0YyvCXbzMYGlEuggtSRTJBrjz/d/+teq/okoO55Kgt4kka4phaQiAjdzvUryhD\nqXOjF2FaQH5ZDWZEm39QFXBqBizNaq3pRGQGZe9E7Kb9dTtVCZOuyfSrgwyCteQx\n1so/z4ymJfgYtZFctAX2etw=\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-67drd@campusadel-2980a.iam.gserviceaccount.com",
          "client_id": "116017877587458049851",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-67drd%40campusadel-2980a.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
