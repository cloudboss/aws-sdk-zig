pub const Identity = struct {
    /// The source IP address of the TCP connection making the request to API
    /// Gateway.
    source_ip: []const u8,

    /// The User Agent of the API caller.
    user_agent: []const u8,

    pub const json_field_names = .{
        .source_ip = "SourceIp",
        .user_agent = "UserAgent",
    };
};
