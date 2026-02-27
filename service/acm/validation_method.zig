pub const ValidationMethod = enum {
    email,
    dns,
    http,

    pub const json_field_names = .{
        .email = "EMAIL",
        .dns = "DNS",
        .http = "HTTP",
    };
};
