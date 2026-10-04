const Channel = @import("channel.zig").Channel;

/// Placeholder documentation for UpdateChannelResponse
pub const UpdateChannelResponse = struct {
    channel: ?Channel = null,

    pub const json_field_names = .{
        .channel = "Channel",
    };
};
