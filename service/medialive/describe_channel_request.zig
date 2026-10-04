/// Placeholder documentation for DescribeChannelRequest
pub const DescribeChannelRequest = struct {
    /// channel ID
    channel_id: []const u8,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
    };
};
