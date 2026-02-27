const QueueName = @import("queue_name.zig").QueueName;
const QueuePriority = @import("queue_priority.zig").QueuePriority;

/// The queue information for the specified quantum task.
pub const QuantumTaskQueueInfo = struct {
    /// Optional. Provides more information about the queue position. For example,
    /// if the quantum task is complete and no longer in the queue, the message
    /// field contains that information.
    message: ?[]const u8,

    /// Current position of the quantum task in the quantum tasks queue.
    position: []const u8,

    /// The name of the queue.
    queue: QueueName,

    /// Optional. Specifies the priority of the queue. Quantum tasks in a priority
    /// queue are processed before the quantum tasks in a normal queue.
    queue_priority: ?QueuePriority,

    pub const json_field_names = .{
        .message = "message",
        .position = "position",
        .queue = "queue",
        .queue_priority = "queuePriority",
    };
};
