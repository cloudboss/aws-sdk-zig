pub const RecommendationLanguage = enum {
    english,
    japanese,
    chinese,
    french,
    german,
    korean,
    traditional_chinese,
    italian,
    spanish,
    brazilian_portuguese,
    bahasa_indonesia,

    pub const json_field_names = .{
        .english = "ENGLISH",
        .japanese = "JAPANESE",
        .chinese = "CHINESE",
        .french = "FRENCH",
        .german = "GERMAN",
        .korean = "KOREAN",
        .traditional_chinese = "TRADITIONAL_CHINESE",
        .italian = "ITALIAN",
        .spanish = "SPANISH",
        .brazilian_portuguese = "BRAZILIAN_PORTUGUESE",
        .bahasa_indonesia = "BAHASA_INDONESIA",
    };
};
