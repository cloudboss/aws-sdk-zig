/// Placeholder documentation for ChannelEgressEndpoint
pub const ChannelEgressEndpoint = struct {
    /// Public IP of where a channel's output comes from
    source_ip: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_ip = "SourceIp",
    };
};
