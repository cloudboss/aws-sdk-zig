pub const Platform = enum {
    apns,
    apns_sandbox,
    gcm,
    adm,

    pub const json_field_names = .{
        .apns = "APNS",
        .apns_sandbox = "APNS_SANDBOX",
        .gcm = "GCM",
        .adm = "ADM",
    };
};
