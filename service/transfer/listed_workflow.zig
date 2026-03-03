/// Contains the identifier, text description, and Amazon Resource Name (ARN)
/// for the workflow.
pub const ListedWorkflow = struct {
    /// Specifies the unique Amazon Resource Name (ARN) for the workflow.
    arn: ?[]const u8 = null,

    /// Specifies the text description for the workflow.
    description: ?[]const u8 = null,

    /// A unique identifier for the workflow.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .workflow_id = "WorkflowId",
    };
};
