pub const DeviceType = enum {
    gcm,
    apns,
    apns_sandbox,

    pub const json_field_names = .{
        .gcm = "GCM",
        .apns = "APNS",
        .apns_sandbox = "APNS_SANDBOX",
    };
};
