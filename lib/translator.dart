import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Translator {
  static const String _DAK_KEY = 'DEEPL_AUTH_KEY';

  static Future<TranslationResponse> translate(
      TranslationRequest transReq) async {
    Uri url = Uri.https('api-free.deepl.com', '/v2/translate', {
      'source_lang': transReq.sourceLangCode,
      'target_lang': transReq.targetLangCode,
      'text': transReq.text,
    });
    Response res = await get(url, headers: {
      'Accept': 'application/json',
      'Authorization': dotenv.env[_DAK_KEY] ?? '',
    });
    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));
    if (res.statusCode == 200) {
      Map<String, dynamic> translation = json['translations'][0];
      return TranslationResponse(
          translation['detected_source_language'] as String,
          translation['text'] as String);
    } else {
      throw TranslationError(res.statusCode, json['message'] as String);
    }
  }
}

class TranslationRequest {
  final String sourceLangCode;
  final String targetLangCode;
  final String text;

  TranslationRequest(this.sourceLangCode, this.targetLangCode, this.text);
}

class TranslationResponse {
  final String detectedSourceLangCode;
  final String translatedText;

  TranslationResponse(this.detectedSourceLangCode, this.translatedText);
}

class TranslationError {
  final int statusCode;
  final String message;

  TranslationError(this.statusCode, this.message);
}
