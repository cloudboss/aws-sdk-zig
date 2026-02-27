const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Contains details about this version of the workflow.
pub const WorkflowVersion = struct {
    /// The Amazon Resource Name (ARN) of the workflow resource.
    arn: ?[]const u8,

    /// The timestamp when Image Builder created the workflow version.
    date_created: ?[]const u8,

    /// Describes the workflow.
    description: ?[]const u8,

    /// The name of the workflow.
    name: ?[]const u8,

    /// The owner of the workflow resource.
    owner: ?[]const u8,

    /// The image creation stage that this workflow applies to. Image Builder
    /// currently
    /// supports build and test stage workflows.
    type: ?WorkflowType,

    /// The semantic version of the workflow resource. The format includes three
    /// nodes: ...
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .date_created = "dateCreated",
        .description = "description",
        .name = "name",
        .owner = "owner",
        .type = "type",
        .version = "version",
    };
};
