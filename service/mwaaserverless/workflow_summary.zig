const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;

/// Summary information about a workflow, including basic identification and
/// metadata.
pub const WorkflowSummary = struct {
    /// The timestamp when the workflow was created, in ISO 8601 date-time format.
    created_at: ?i64 = null,

    /// The description of the workflow.
    description: ?[]const u8 = null,

    /// The timestamp when the workflow was last modified, in ISO 8601 date-time
    /// format.
    modified_at: ?i64 = null,

    /// The name of the workflow.
    name: ?[]const u8 = null,

    /// The trigger mode for the workflow execution.
    trigger_mode: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workflow.
    workflow_arn: []const u8,

    /// The current status of the workflow.
    workflow_status: ?WorkflowStatus = null,

    /// The version identifier of the workflow.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .trigger_mode = "TriggerMode",
        .workflow_arn = "WorkflowArn",
        .workflow_status = "WorkflowStatus",
        .workflow_version = "WorkflowVersion",
    };
};
