const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;
const TraceLocation = @import("trace_location.zig").TraceLocation;

/// Summary information about a workflow run, including execution status and
/// timing.
pub const WorkflowRunSummary = struct {
    /// The timestamp when the workflow run completed execution, if applicable.
    ended_at: ?i64,

    /// The timestamp when the workflow run started execution.
    started_at: i64,

    /// The current execution status of the workflow run.
    status: WorkflowRunStatus,

    /// The location where trace information for this workflow run is stored.
    trace_location: ?TraceLocation,

    /// The Amazon Resource Name (ARN) of the workflow run.
    workflow_run_arn: []const u8,

    /// The unique identifier of the workflow run.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .ended_at = "endedAt",
        .started_at = "startedAt",
        .status = "status",
        .trace_location = "traceLocation",
        .workflow_run_arn = "workflowRunArn",
        .workflow_run_id = "workflowRunId",
    };
};
