const QueueName = @import("queue_name.zig").QueueName;

/// Information about the queue for a specified hybrid job.
pub const HybridJobQueueInfo = struct {
    /// Optional. Provides more information about the queue position. For example,
    /// if the hybrid job is complete and no longer in the queue, the message field
    /// contains that information.
    message: ?[]const u8,

    /// Current position of the hybrid job in the jobs queue.
    position: []const u8,

    /// The name of the queue.
    queue: QueueName,

    pub const json_field_names = .{
        .message = "message",
        .position = "position",
        .queue = "queue",
    };
};
