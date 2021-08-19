class Lang {
  String code;
  String name;
  String flagEmoji;

  Lang(this.code, this.name, this.flagEmoji);
}

class LangRegister {
  static final List<Lang> sourceLangs = [
    new Lang('', 'Detect Language', '🇺🇳'),
    new Lang('BG', 'Bulgarian', '🇧🇬'),
    new Lang('ZH', 'Chinese', '🇨🇳'),
    new Lang('CS', 'Czech', '🇨🇿'),
    new Lang('DA', 'Danish', '🇩🇰'),
    new Lang('NL', 'Dutch', '🇳🇱'),
    new Lang('EN', 'English', '🇬🇧'),
    new Lang('ET', 'Estonian', '🇪🇪'),
    new Lang('FI', 'Finnish', '🇫🇮'),
    new Lang('FR', 'French', '🇫🇷'),
    new Lang('DE', 'German', '🇩🇪'),
    new Lang('EL', 'Greek', '🇬🇷 '),
    new Lang('ES', 'Spanish', '🇪🇸'),
    new Lang('HU', 'Hungarian', '🇭🇺'),
    new Lang('IT', 'Italian', '🇮🇹'),
    new Lang('JA', 'Japanese', '🇯🇵'),
    new Lang('LT', 'Lithuanian', '🇱🇹'),
    new Lang('LV', 'Latvian', '🇱🇻'),
    new Lang('PL', 'Polish', '🇵🇱'),
    new Lang('PT', 'Portuguese', '🇵🇹'),
    new Lang('RO', 'Romanian', '🇷🇴'),
    new Lang('RU', 'Russian', '🇷🇺'),
    new Lang('SK', 'Slovak', '🇸🇰'),
    new Lang('SL', 'Slovenian', '🇸🇮'),
    new Lang('SV', 'Swedish', '🇸🇪'),
  ];

  static final List<Lang> targetLangs = [
    new Lang('BG', 'Bulgarian', '🇧🇬'),
    new Lang('CS', 'Czech', '🇨🇿'),
    new Lang('ZH', 'Chinese', '🇨🇳'),
    new Lang('DA', 'Danish', '🇩🇰'),
    new Lang('EN-GB', 'British English', '🇬🇧'),
    new Lang('EN-US', 'American English', '🇺🇸'),
    new Lang('ET', 'Estonian', '🇪🇪'),
    new Lang('FI', 'Finnish', '🇫🇮'),
    new Lang('FR', 'French', '🇫🇷'),
    new Lang('DE', 'German', '🇩🇪'),
    new Lang('EL', 'Greek', '🇬🇷'),
    new Lang('ES', 'Spanish', '🇪🇸'),
    new Lang('HU', 'Hungarian', '🇭🇺'),
    new Lang('IT', 'Italian', '🇮🇹'),
    new Lang('JA', 'Japanese', '🇯🇵'),
    new Lang('LT', 'Lithuanian', '🇱🇹'),
    new Lang('LV', 'Latvian', '🇱🇻'),
    new Lang('NL', 'Dutch', '🇳🇱'),
    new Lang('PL', 'Polish', '🇵🇱'),
    new Lang('PT', 'Portuguese', '🇵🇹'),
    new Lang('PT-BR', 'Brazilian Portuguese', '🇧🇷'),
    new Lang('RO', 'Romanian', '🇷🇴'),
    new Lang('RU', 'Russian', '🇷🇺'),
    new Lang('SK', 'Slovak', '🇸🇰'),
    new Lang('SL', 'Slovenian', '🇸🇮'),
    new Lang('SV', 'Swedish', '🇸🇪'),
  ];
}
