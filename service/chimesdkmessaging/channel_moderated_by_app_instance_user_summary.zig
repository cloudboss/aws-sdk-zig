const ChannelSummary = @import("channel_summary.zig").ChannelSummary;

/// Summary of the details of a moderated channel.
pub const ChannelModeratedByAppInstanceUserSummary = struct {
    /// Summary of the details of a `Channel`.
    channel_summary: ?ChannelSummary,

    pub const json_field_names = .{
        .channel_summary = "ChannelSummary",
    };
};
