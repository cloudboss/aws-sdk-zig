pub const ObjectStorageServerProtocol = enum {
    https,
    http,

    pub const json_field_names = .{
        .https = "HTTPS",
        .http = "HTTP",
    };
};
