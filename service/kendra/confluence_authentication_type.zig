pub const ConfluenceAuthenticationType = enum {
    http_basic,
    pat,

    pub const json_field_names = .{
        .http_basic = "HTTP_BASIC",
        .pat = "PAT",
    };
};
