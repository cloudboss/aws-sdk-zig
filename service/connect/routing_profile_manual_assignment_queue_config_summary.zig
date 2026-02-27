const Channel = @import("channel.zig").Channel;

/// Contains summary information about a routing profile manual assignment
/// queue.
pub const RoutingProfileManualAssignmentQueueConfigSummary = struct {
    /// The channels this queue supports. Valid Values: CHAT | TASK | EMAIL
    ///
    /// VOICE is not supported. The information shown below is incorrect. We're
    /// working to correct it.
    channel: Channel,

    /// The Amazon Resource Name (ARN) of the queue.
    queue_arn: []const u8,

    /// The identifier for the queue.
    queue_id: []const u8,

    /// The name of the queue.
    queue_name: []const u8,

    pub const json_field_names = .{
        .channel = "Channel",
        .queue_arn = "QueueArn",
        .queue_id = "QueueId",
        .queue_name = "QueueName",
    };
};
