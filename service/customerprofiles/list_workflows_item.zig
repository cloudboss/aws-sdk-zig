const Status = @import("status.zig").Status;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// A workflow in list of workflows.
pub const ListWorkflowsItem = struct {
    /// Creation timestamp for workflow.
    created_at: i64,

    /// Last updated timestamp for workflow.
    last_updated_at: i64,

    /// Status of workflow execution.
    status: Status,

    /// Description for workflow execution status.
    status_description: []const u8,

    /// Unique identifier for the workflow.
    workflow_id: []const u8,

    /// The type of workflow. The only supported value is APPFLOW_INTEGRATION.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .status_description = "StatusDescription",
        .workflow_id = "WorkflowId",
        .workflow_type = "WorkflowType",
    };
};
