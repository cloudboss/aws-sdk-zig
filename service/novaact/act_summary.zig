const ActStatus = @import("act_status.zig").ActStatus;
const TraceLocation = @import("trace_location.zig").TraceLocation;

/// Summary information about an act, including its status and execution timing.
pub const ActSummary = struct {
    /// The unique identifier of the act.
    act_id: []const u8,

    /// The timestamp when the act completed execution, if applicable.
    ended_at: ?i64,

    /// The unique identifier of the session containing this act.
    session_id: []const u8,

    /// The timestamp when the act started execution.
    started_at: i64,

    /// The current execution status of the act.
    status: ActStatus,

    /// The location where trace information for this act is stored.
    trace_location: ?TraceLocation,

    /// The unique identifier of the workflow run containing this act.
    workflow_run_id: []const u8,

    pub const json_field_names = .{
        .act_id = "actId",
        .ended_at = "endedAt",
        .session_id = "sessionId",
        .started_at = "startedAt",
        .status = "status",
        .trace_location = "traceLocation",
        .workflow_run_id = "workflowRunId",
    };
};
