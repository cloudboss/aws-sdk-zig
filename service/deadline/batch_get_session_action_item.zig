const AcquiredLimit = @import("acquired_limit.zig").AcquiredLimit;
const SessionActionDefinition = @import("session_action_definition.zig").SessionActionDefinition;
const TaskRunManifestPropertiesResponse = @import("task_run_manifest_properties_response.zig").TaskRunManifestPropertiesResponse;
const SessionActionStatus = @import("session_action_status.zig").SessionActionStatus;

/// The details of a session action returned in a batch get operation.
pub const BatchGetSessionActionItem = struct {
    /// The limits that were acquired for the session action.
    acquired_limits: ?[]const AcquiredLimit = null,

    /// The session action definition.
    definition: SessionActionDefinition,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The farm ID of the session action.
    farm_id: []const u8,

    /// The job ID of the session action.
    job_id: []const u8,

    /// The manifests for the session action.
    manifests: ?[]const TaskRunManifestPropertiesResponse = null,

    /// The exit code to apply to the session action.
    process_exit_code: ?i32 = null,

    /// The message that communicates the progress of the session action.
    progress_message: ?[]const u8 = null,

    /// The completion percentage for the session action.
    progress_percent: ?f32 = null,

    /// The queue ID of the session action.
    queue_id: []const u8,

    /// The session action ID.
    session_action_id: []const u8,

    /// The session ID for the session action.
    session_id: []const u8,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The status of the session action.
    status: SessionActionStatus,

    /// The date and time the resource was updated by a worker.
    worker_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .acquired_limits = "acquiredLimits",
        .definition = "definition",
        .ended_at = "endedAt",
        .farm_id = "farmId",
        .job_id = "jobId",
        .manifests = "manifests",
        .process_exit_code = "processExitCode",
        .progress_message = "progressMessage",
        .progress_percent = "progressPercent",
        .queue_id = "queueId",
        .session_action_id = "sessionActionId",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .status = "status",
        .worker_updated_at = "workerUpdatedAt",
    };
};
