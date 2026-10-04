const ChannelContext = @import("channel_context.zig").ChannelContext;

/// Event trigger context data
pub const EventTriggerContext = struct {
    channel_context: ?ChannelContext = null,

    source_event: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_context = "channelContext",
        .source_event = "sourceEvent",
    };
};
