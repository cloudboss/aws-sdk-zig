pub const ServiceNowAuthenticationType = enum {
    http_basic,
    oauth2,

    pub const json_field_names = .{
        .http_basic = "HTTP_BASIC",
        .oauth2 = "OAUTH2",
    };
};
