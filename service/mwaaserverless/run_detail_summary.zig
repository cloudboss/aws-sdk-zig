const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;

/// Summary information about a workflow run's execution details, including
/// status and timing information.
pub const RunDetailSummary = struct {
    /// The timestamp when the workflow run was created, in ISO 8601 date-time
    /// format.
    created_on: ?i64 = null,

    /// The timestamp when the workflow run completed execution, in ISO 8601
    /// date-time format. This value is null if the run is not complete.
    ended_at: ?i64 = null,

    /// The timestamp when the workflow run started execution, in ISO 8601 date-time
    /// format.
    started_at: ?i64 = null,

    /// The current status of the workflow run.
    status: ?WorkflowRunStatus = null,

    pub const json_field_names = .{
        .created_on = "CreatedOn",
        .ended_at = "EndedAt",
        .started_at = "StartedAt",
        .status = "Status",
    };
};
