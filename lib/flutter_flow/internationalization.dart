import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'mr', 'hi'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? mrText = '',
    String? hiText = '',
  }) =>
      [enText, mrText, hiText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // uploadpage
  {
    'qzcykyyk': {
      'en': 'Select Audio File',
      'hi': 'ऑडियो फ़ाइल चुनें',
      'mr': 'ऑडिओ फाइल निवडा',
    },
    'xspqw780': {
      'en':
          'Choose an audio file (.mp3, .wav) to upload for sentiment analysis',
      'hi':
          'भावना विश्लेषण के लिए अपलोड करने हेतु एक ऑडियो फ़ाइल (.mp3, .wav) चुनें',
      'mr':
          'भावना विश्लेषणासाठी अपलोड करण्यासाठी एक ऑडिओ फाइल (.mp3, .wav) निवडा.',
    },
    '9rpr2hvf': {
      'en': 'Tap to select audio file',
      'hi': 'ऑडियो फ़ाइल चुनने के लिए टैप करें',
      'mr': 'ऑडिओ फाइल निवडण्यासाठी टॅप करा',
    },
    '89dyqhl5': {
      'en': 'Submit for Analysis',
      'hi': 'विश्लेषण के लिए सबमिट करें',
      'mr': 'विश्लेषणासाठी सबमिट करा',
    },
    'e3182w2g': {
      'en': 'Upload',
      'hi': 'अपलोड करें',
      'mr': 'अपलोड करा',
    },
  },
  // sample
  {
    'us8enbc8': {
      'en': 'Thank You!',
      'hi': 'धन्यवाद!',
      'mr': 'धन्यवाद!',
    },
    'aksct0s0': {
      'en':
          'Your submission has been received successfully. We appreciate your participation!',
      'hi':
          'आपकी प्रविष्टि सफलतापूर्वक प्राप्त हो गई है। हम आपकी भागीदारी की सराहना करते हैं!',
      'mr':
          'तुमचे सबमिशन यशस्वीरित्या प्राप्त झाले आहे. तुमच्या सहभागाबद्दल आम्ही आभारी आहोत!',
    },
    'ryi4pzv7': {
      'en': 'Return to Home',
      'hi': 'घर पर वापस',
      'mr': 'घरी परत या',
    },
    'o6uwj9jg': {
      'en': 'We\'ll be in touch soon!',
      'hi': 'हम जल्द ही संपर्क में होंगे!',
      'mr': 'आम्ही लवकरच संपर्क साधू!',
    },
  },
  // analysispage
  {
    'fhiysvzz': {
      'en': 'Call Analysis',
      'hi': 'कॉल विश्लेषण',
      'mr': 'कॉल विश्लेषण',
    },
    'n3n60jfe': {
      'en': 'Call Transcript',
      'hi': 'कॉल ट्रांसक्रिप्ट',
      'mr': 'कॉल ट्रान्सक्रिप्ट',
    },
    'fsc4zxep': {
      'en': 'View Full Transcript',
      'hi': 'पूर्ण प्रतिलेख देखें',
      'mr': 'पूर्ण ट्रान्सक्रिप्ट पहा',
    },
    'o3gl3088': {
      'en': 'Dominant Emotions',
      'hi': 'प्रबल भावनाएँ',
      'mr': 'प्रभावी भावना',
    },
    'l7ck68bd': {
      'en': 'Executive Suggestions',
      'hi': 'कार्यकारी सुझाव',
      'mr': 'कार्यकारी सूचना',
    },
  },
  // Miscellaneous
  {
    'f7wpylhb': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'b2jfbrl8': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'o9zw6ytj': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'pjcgp1f4': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'oia4y048': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'ovqip37j': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'x12wq4mr': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'niw5kk33': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'hu9hfcdn': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'z5p9u9kw': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'wihzrxdo': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'pglin2y1': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'w0zwmp2a': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'fr6hop03': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'atq2ngo4': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'r4q86hn6': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'dslrp5tl': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'ynuqku23': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    '1ma8q4gm': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'l3jdhvgp': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    '2v4r2mud': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    '179309iv': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'zo03mhtf': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    'cjpav6mw': {
      'en': '',
      'hi': '',
      'mr': '',
    },
    '563d9oem': {
      'en': '',
      'hi': '',
      'mr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
