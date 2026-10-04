const WorkflowStep = @import("workflow_step.zig").WorkflowStep;
const Tag = @import("tag.zig").Tag;

/// Describes the properties of the specified workflow
pub const DescribedWorkflow = struct {
    /// Specifies the unique Amazon Resource Name (ARN) for the workflow.
    arn: []const u8,

    /// Specifies the text description for the workflow.
    description: ?[]const u8 = null,

    /// Specifies the steps (actions) to take if errors are encountered during
    /// execution of the workflow.
    on_exception_steps: ?[]const WorkflowStep = null,

    /// Specifies the details for the steps that are in the specified workflow.
    steps: ?[]const WorkflowStep = null,

    /// Specifies the log groups to which your workflow logs are sent.
    ///
    /// To specify a log group, you must provide the ARN for an existing log group.
    /// In this case, the format of the log group is as follows:
    ///
    /// `arn:partition:logs:region-name:amazon-account-id:log-group:log-group-name:*`
    ///
    /// For example, `arn:aws:logs:us-east-1:111122223333:log-group:mytestgroup:*`
    structured_log_destinations: ?[]const []const u8 = null,

    /// Key-value pairs that can be used to group and search for workflows. Tags are
    /// metadata attached to workflows for any purpose.
    tags: ?[]const Tag = null,

    /// A unique identifier for the workflow.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .description = "Description",
        .on_exception_steps = "OnExceptionSteps",
        .steps = "Steps",
        .structured_log_destinations = "StructuredLogDestinations",
        .tags = "Tags",
        .workflow_id = "WorkflowId",
    };
};
