const AttemptContainerDetail = @import("attempt_container_detail.zig").AttemptContainerDetail;
const AttemptEcsTaskDetails = @import("attempt_ecs_task_details.zig").AttemptEcsTaskDetails;

/// An object that represents a job attempt.
pub const AttemptDetail = struct {
    /// The details for the container in this job attempt.
    container: ?AttemptContainerDetail = null,

    /// The Unix timestamp (in milliseconds) for when the attempt was started (when
    /// the attempt
    /// transitioned from the `STARTING` state to the `RUNNING` state).
    started_at: ?i64 = null,

    /// A short, human-readable string to provide additional details for the current
    /// status of the
    /// job attempt.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp (in milliseconds) for when the attempt was stopped (when
    /// the attempt
    /// transitioned from the `RUNNING` state to a terminal state, such as
    /// `SUCCEEDED` or `FAILED`).
    stopped_at: ?i64 = null,

    /// The properties for a task definition that describes the container and volume
    /// definitions of
    /// an Amazon ECS task.
    task_properties: ?[]const AttemptEcsTaskDetails = null,

    pub const json_field_names = .{
        .container = "container",
        .started_at = "startedAt",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
        .task_properties = "taskProperties",
    };
};
