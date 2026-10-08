/// Represents a Slack channel with its ID and optional name.
pub const SlackChannel = struct {
    /// Slack channel ID
    channel_id: []const u8,

    /// Slack channel name
    channel_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_id = "channelId",
        .channel_name = "channelName",
    };
};
