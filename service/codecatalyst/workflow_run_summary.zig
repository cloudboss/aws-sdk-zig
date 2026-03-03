const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;
const WorkflowRunStatusReason = @import("workflow_run_status_reason.zig").WorkflowRunStatusReason;

/// Information about a workflow run.
pub const WorkflowRunSummary = struct {
    /// The date and time the workflow run ended, in coordinated universal time
    /// (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6)
    end_time: ?i64 = null,

    /// The system-generated unique ID of the workflow run.
    id: []const u8,

    /// The date and time the workflow was last updated, in coordinated universal
    /// time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6)
    last_updated_time: i64,

    /// The date and time the workflow run began, in coordinated universal time
    /// (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    start_time: i64,

    /// The status of the workflow run.
    status: WorkflowRunStatus,

    /// The reasons for the workflow run status.
    status_reasons: ?[]const WorkflowRunStatusReason = null,

    /// The system-generated unique ID of the workflow.
    workflow_id: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .id = "id",
        .last_updated_time = "lastUpdatedTime",
        .start_time = "startTime",
        .status = "status",
        .status_reasons = "statusReasons",
        .workflow_id = "workflowId",
        .workflow_name = "workflowName",
    };
};
