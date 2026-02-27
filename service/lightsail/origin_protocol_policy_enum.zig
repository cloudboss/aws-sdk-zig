pub const OriginProtocolPolicyEnum = enum {
    http_only,
    https_only,

    pub const json_field_names = .{
        .http_only = "HTTPOnly",
        .https_only = "HTTPSOnly",
    };
};
