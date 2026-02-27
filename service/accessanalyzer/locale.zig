pub const Locale = enum {
    de,
    en,
    es,
    fr,
    it,
    ja,
    ko,
    pt_br,
    zh_cn,
    zh_tw,

    pub const json_field_names = .{
        .de = "DE",
        .en = "EN",
        .es = "ES",
        .fr = "FR",
        .it = "IT",
        .ja = "JA",
        .ko = "KO",
        .pt_br = "PT_BR",
        .zh_cn = "ZH_CN",
        .zh_tw = "ZH_TW",
    };
};
