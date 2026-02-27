pub const Protocol = enum {
    http,
    https,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
    };
};
