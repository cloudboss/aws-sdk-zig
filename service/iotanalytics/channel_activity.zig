/// The activity that determines the source of the messages to be processed.
pub const ChannelActivity = struct {
    /// The name of the channel from which the messages are processed.
    channel_name: []const u8,

    /// The name of the channel activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_name = "channelName",
        .name = "name",
        .next = "next",
    };
};
