const QueueName = @import("queue_name.zig").QueueName;
const QueuePriority = @import("queue_priority.zig").QueuePriority;

/// Information about quantum tasks and hybrid jobs queued on a device.
pub const DeviceQueueInfo = struct {
    /// The name of the queue.
    queue: QueueName,

    /// Optional. Specifies the priority of the queue. Quantum tasks in a priority
    /// queue are processed before the quantum tasks in a normal queue.
    queue_priority: ?QueuePriority,

    /// The number of hybrid jobs or quantum tasks in the queue for a given device.
    queue_size: []const u8,

    pub const json_field_names = .{
        .queue = "queue",
        .queue_priority = "queuePriority",
        .queue_size = "queueSize",
    };
};
