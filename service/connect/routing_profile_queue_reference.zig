const Channel = @import("channel.zig").Channel;

/// Contains the channel and queue identifier for a routing profile.
pub const RoutingProfileQueueReference = struct {
    /// The channels agents can handle in the Contact Control Panel (CCP) for this
    /// routing profile.
    channel: Channel,

    /// The identifier for the queue.
    queue_id: []const u8,

    pub const json_field_names = .{
        .channel = "Channel",
        .queue_id = "QueueId",
    };
};
