const ChannelSummary = @import("channel_summary.zig").ChannelSummary;

/// Placeholder documentation for ListChannelsResponse
pub const ListChannelsResponse = struct {
    channels: ?[]const ChannelSummary = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channels = "Channels",
        .next_token = "NextToken",
    };
};
