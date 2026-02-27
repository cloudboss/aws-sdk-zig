pub const DisplayLanguageCode = enum {
    de,
    en,
    es,
    fr,
    it,
    ja,
    ko,
    pt,
    zh,
    zh_tw,

    pub const json_field_names = .{
        .de = "DE",
        .en = "EN",
        .es = "ES",
        .fr = "FR",
        .it = "IT",
        .ja = "JA",
        .ko = "KO",
        .pt = "PT",
        .zh = "ZH",
        .zh_tw = "ZH_TW",
    };
};
