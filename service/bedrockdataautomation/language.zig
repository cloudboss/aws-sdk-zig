/// Supported input languages
pub const Language = enum {
    en,
    de,
    es,
    fr,
    it,
    pt,
    ja,
    ko,
    cn,
    tw,
    hk,

    pub const json_field_names = .{
        .en = "EN",
        .de = "DE",
        .es = "ES",
        .fr = "FR",
        .it = "IT",
        .pt = "PT",
        .ja = "JA",
        .ko = "KO",
        .cn = "CN",
        .tw = "TW",
        .hk = "HK",
    };
};
