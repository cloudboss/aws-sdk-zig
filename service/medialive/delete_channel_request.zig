/// Placeholder documentation for DeleteChannelRequest
pub const DeleteChannelRequest = struct {
    /// Unique ID of the channel.
    channel_id: []const u8,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
    };
};
