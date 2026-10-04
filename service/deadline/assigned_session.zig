const aws = @import("aws");

const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const AssignedSessionAction = @import("assigned_session_action.zig").AssignedSessionAction;

/// The assigned session for the worker.
pub const AssignedSession = struct {
    /// The job ID for the assigned session.
    job_id: []const u8,

    /// The log configuration for the worker's assigned session.
    log_configuration: LogConfiguration,

    /// Key-value hints that the service provides to guide how the session runs.
    /// This value is used by the worker agent.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The queue ID of the assigned session.
    queue_id: []const u8,

    /// The session actions to apply to the assigned session.
    session_actions: []const AssignedSessionAction,

    pub const json_field_names = .{
        .job_id = "jobId",
        .log_configuration = "logConfiguration",
        .metadata = "metadata",
        .queue_id = "queueId",
        .session_actions = "sessionActions",
    };
};
