/// The IP rules of the IP access settings.
pub const IpRule = struct {
    /// The description of the IP rule.
    description: ?[]const u8 = null,

    /// The IP range of the IP rule.
    ip_range: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .ip_range = "ipRange",
    };
};
