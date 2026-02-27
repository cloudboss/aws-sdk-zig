pub const LocaleType = enum {
    en,
    fr,
    ko,
    de,
    es,
    ja,
    ru,
    zh_cn,
    zh_tw,
    pt_br,
    default,

    pub const json_field_names = .{
        .en = "EN",
        .fr = "FR",
        .ko = "KO",
        .de = "DE",
        .es = "ES",
        .ja = "JA",
        .ru = "RU",
        .zh_cn = "ZH_CN",
        .zh_tw = "ZH_TW",
        .pt_br = "PT_BR",
        .default = "DEFAULT",
    };
};
