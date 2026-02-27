pub const ListenerProtocol = enum {
    /// Indicates HTTP protocol
    http,
    /// Indicates HTTPS protocol
    https,
    /// Indicates TLS_PASSTHROUGH protocol
    tls_passthrough,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .tls_passthrough = "TLS_PASSTHROUGH",
    };
};
