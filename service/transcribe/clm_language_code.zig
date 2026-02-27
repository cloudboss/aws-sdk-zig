pub const CLMLanguageCode = enum {
    en_us,
    hi_in,
    es_us,
    en_gb,
    en_au,
    de_de,
    ja_jp,

    pub const json_field_names = .{
        .en_us = "EN_US",
        .hi_in = "HI_IN",
        .es_us = "ES_US",
        .en_gb = "EN_GB",
        .en_au = "EN_AU",
        .de_de = "DE_DE",
        .ja_jp = "JA_JP",
    };
};
