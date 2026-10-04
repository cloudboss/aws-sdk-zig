const Channel = @import("channel.zig").Channel;

/// Placeholder documentation for CreateChannelResponse
pub const CreateChannelResponse = struct {
    channel: ?Channel = null,

    pub const json_field_names = .{
        .channel = "Channel",
    };
};
