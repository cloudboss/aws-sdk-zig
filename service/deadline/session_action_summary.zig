const SessionActionDefinitionSummary = @import("session_action_definition_summary.zig").SessionActionDefinitionSummary;
const TaskRunManifestPropertiesResponse = @import("task_run_manifest_properties_response.zig").TaskRunManifestPropertiesResponse;
const SessionActionStatus = @import("session_action_status.zig").SessionActionStatus;

/// The details of a session action.
pub const SessionActionSummary = struct {
    /// The session action definition.
    definition: SessionActionDefinitionSummary,

    /// The date and time the resource ended running.
    ended_at: ?i64 = null,

    /// The list of manifest properties that describe file attachments for the task
    /// run.
    manifests: ?[]const TaskRunManifestPropertiesResponse = null,

    /// The completion percentage for the session action.
    progress_percent: ?f32 = null,

    /// The session action ID.
    session_action_id: []const u8,

    /// The date and time the resource started running.
    started_at: ?i64 = null,

    /// The status of the session action.
    status: SessionActionStatus,

    /// The Linux timestamp of the last date and time that the session action was
    /// updated.
    worker_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .definition = "definition",
        .ended_at = "endedAt",
        .manifests = "manifests",
        .progress_percent = "progressPercent",
        .session_action_id = "sessionActionId",
        .started_at = "startedAt",
        .status = "status",
        .worker_updated_at = "workerUpdatedAt",
    };
};
