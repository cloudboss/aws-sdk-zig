pub const Locale = enum {
    de,
    en,
    es,
    fr,
    id,
    it,
    jp,
    kr,
    br,
    cn,
    tw,

    pub const json_field_names = .{
        .de = "DE",
        .en = "EN",
        .es = "ES",
        .fr = "FR",
        .id = "ID",
        .it = "IT",
        .jp = "JP",
        .kr = "KR",
        .br = "BR",
        .cn = "CN",
        .tw = "TW",
    };
};
