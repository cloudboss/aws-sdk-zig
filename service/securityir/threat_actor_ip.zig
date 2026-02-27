pub const ThreatActorIp = struct {
    ip_address: []const u8,

    user_agent: ?[]const u8,

    pub const json_field_names = .{
        .ip_address = "ipAddress",
        .user_agent = "userAgent",
    };
};
