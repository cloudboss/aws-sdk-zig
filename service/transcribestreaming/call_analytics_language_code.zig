pub const CallAnalyticsLanguageCode = enum {
    en_us,
    en_gb,
    es_us,
    fr_ca,
    fr_fr,
    en_au,
    it_it,
    de_de,
    pt_br,

    pub const json_field_names = .{
        .en_us = "EN_US",
        .en_gb = "EN_GB",
        .es_us = "ES_US",
        .fr_ca = "FR_CA",
        .fr_fr = "FR_FR",
        .en_au = "EN_AU",
        .it_it = "IT_IT",
        .de_de = "DE_DE",
        .pt_br = "PT_BR",
    };
};
