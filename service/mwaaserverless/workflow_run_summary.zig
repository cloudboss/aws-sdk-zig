const RunDetailSummary = @import("run_detail_summary.zig").RunDetailSummary;
const RunType = @import("run_type.zig").RunType;

/// Summary information about a workflow run, including basic identification and
/// status information.
pub const WorkflowRunSummary = struct {
    /// Summary details about the workflow run execution.
    run_detail_summary: ?RunDetailSummary = null,

    /// The unique identifier of the workflow run.
    run_id: ?[]const u8 = null,

    /// The type of workflow run.
    run_type: ?RunType = null,

    /// The Amazon Resource Name (ARN) of the workflow that contains this run.
    workflow_arn: ?[]const u8 = null,

    /// The version of the workflow used for this run.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .run_detail_summary = "RunDetailSummary",
        .run_id = "RunId",
        .run_type = "RunType",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};
