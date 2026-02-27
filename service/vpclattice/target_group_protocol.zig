pub const TargetGroupProtocol = enum {
    /// Indicates HTTP protocol
    http,
    /// Indicates HTTPS protocol
    https,
    /// Indicates TCP protocol
    tcp,

    pub const json_field_names = .{
        .http = "HTTP",
        .https = "HTTPS",
        .tcp = "TCP",
    };
};
