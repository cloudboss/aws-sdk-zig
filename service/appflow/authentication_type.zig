pub const AuthenticationType = enum {
    oauth2,
    apikey,
    basic,
    custom,

    pub const json_field_names = .{
        .oauth2 = "OAUTH2",
        .apikey = "APIKEY",
        .basic = "BASIC",
        .custom = "CUSTOM",
    };
};
