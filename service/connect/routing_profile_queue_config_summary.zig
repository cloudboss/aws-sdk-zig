const Channel = @import("channel.zig").Channel;

/// Contains summary information about a routing profile queue.
pub const RoutingProfileQueueConfigSummary = struct {
    /// The channels this queue supports.
    channel: Channel,

    /// The delay, in seconds, that a contact should be in the queue before they are
    /// routed to an available agent. For
    /// more information, see [Queues: priority and
    /// delay](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-routing-profiles-priority.html) in the
    /// *Amazon Connect Administrator Guide*.
    delay: i32 = 0,

    /// The order in which contacts are to be handled for the queue. For more
    /// information, see [Queues: priority and
    /// delay](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-routing-profiles-priority.html).
    priority: i32,

    /// The Amazon Resource Name (ARN) of the queue.
    queue_arn: []const u8,

    /// The identifier for the queue.
    queue_id: []const u8,

    /// The name of the queue.
    queue_name: []const u8,

    pub const json_field_names = .{
        .channel = "Channel",
        .delay = "Delay",
        .priority = "Priority",
        .queue_arn = "QueueArn",
        .queue_id = "QueueId",
        .queue_name = "QueueName",
    };
};
