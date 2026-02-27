pub const LanguageCode = enum {
    en,
    es,
    fr,
    de,
    it,
    pt,
    ar,
    hi,
    ja,
    ko,
    zh,
    zh_tw,

    pub const json_field_names = .{
        .en = "EN",
        .es = "ES",
        .fr = "FR",
        .de = "DE",
        .it = "IT",
        .pt = "PT",
        .ar = "AR",
        .hi = "HI",
        .ja = "JA",
        .ko = "KO",
        .zh = "ZH",
        .zh_tw = "ZH_TW",
    };
};
