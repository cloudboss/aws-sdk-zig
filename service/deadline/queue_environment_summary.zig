/// The summary of a queue environment.
pub const QueueEnvironmentSummary = struct {
    /// The name of the queue environment.
    name: []const u8,

    /// The queue environment's priority.
    priority: i32,

    /// The queue environment ID.
    queue_environment_id: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .priority = "priority",
        .queue_environment_id = "queueEnvironmentId",
    };
};
