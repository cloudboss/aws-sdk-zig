const WorkflowDefinitionStatus = @import("workflow_definition_status.zig").WorkflowDefinitionStatus;

/// Summary information about a workflow definition, used in list operations.
pub const WorkflowDefinitionSummary = struct {
    /// The timestamp when the workflow definition was created.
    created_at: i64,

    /// The current status of the workflow definition.
    status: WorkflowDefinitionStatus,

    /// The Amazon Resource Name (ARN) of the workflow definition.
    workflow_definition_arn: []const u8,

    /// The name of the workflow definition.
    workflow_definition_name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .status = "status",
        .workflow_definition_arn = "workflowDefinitionArn",
        .workflow_definition_name = "workflowDefinitionName",
    };
};
