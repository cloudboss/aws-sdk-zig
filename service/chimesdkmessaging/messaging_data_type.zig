pub const MessagingDataType = enum {
    channel,
    channel_message,

    pub const json_field_names = .{
        .channel = "Channel",
        .channel_message = "ChannelMessage",
    };
};
