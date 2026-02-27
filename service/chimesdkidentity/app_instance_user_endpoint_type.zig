pub const AppInstanceUserEndpointType = enum {
    apns,
    apns_sandbox,
    gcm,

    pub const json_field_names = .{
        .apns = "APNS",
        .apns_sandbox = "APNS_SANDBOX",
        .gcm = "GCM",
    };
};
