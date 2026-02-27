pub const DirectoryType = enum {
    simple_ad,
    ad_connector,
    microsoft_ad,
    shared_microsoft_ad,

    pub const json_field_names = .{
        .simple_ad = "SIMPLE_AD",
        .ad_connector = "AD_CONNECTOR",
        .microsoft_ad = "MICROSOFT_AD",
        .shared_microsoft_ad = "SHARED_MICROSOFT_AD",
    };
};
