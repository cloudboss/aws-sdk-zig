const TaskCredentials = @import("task_credentials.zig").TaskCredentials;

/// Contains details about a task scheduled during an execution.
pub const TaskScheduledEventDetails = struct {
    /// The maximum allowed duration between two heartbeats for the task.
    heartbeat_in_seconds: ?i64,

    /// The JSON data passed to the resource referenced in a task state.
    /// Length constraints apply to the payload size, and are expressed as bytes in
    /// UTF-8 encoding.
    parameters: []const u8,

    /// The region of the scheduled task
    region: []const u8,

    /// The action of the resource called by a task state.
    resource: []const u8,

    /// The service name of the resource in a task state.
    resource_type: []const u8,

    /// The credentials that Step Functions uses for the task.
    task_credentials: ?TaskCredentials,

    /// The maximum allowed duration of the task.
    timeout_in_seconds: ?i64,

    pub const json_field_names = .{
        .heartbeat_in_seconds = "heartbeatInSeconds",
        .parameters = "parameters",
        .region = "region",
        .resource = "resource",
        .resource_type = "resourceType",
        .task_credentials = "taskCredentials",
        .timeout_in_seconds = "timeoutInSeconds",
    };
};
