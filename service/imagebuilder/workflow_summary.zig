const aws = @import("aws");

const WorkflowState = @import("workflow_state.zig").WorkflowState;
const WorkflowType = @import("workflow_type.zig").WorkflowType;

/// Contains metadata about the workflow resource.
pub const WorkflowSummary = struct {
    /// The Amazon Resource Name (ARN) of the workflow resource.
    arn: ?[]const u8,

    /// The change description for the current version of the workflow resource.
    change_description: ?[]const u8,

    /// The original creation date of the workflow resource.
    date_created: ?[]const u8,

    /// Describes the workflow.
    description: ?[]const u8,

    /// The name of the workflow.
    name: ?[]const u8,

    /// The owner of the workflow resource.
    owner: ?[]const u8,

    /// Describes the current state of the workflow resource.
    state: ?WorkflowState,

    /// Contains a list of tags that are defined for the workflow.
    tags: ?[]const aws.map.StringMapEntry,

    /// The image creation stage that this workflow applies to. Image Builder
    /// currently
    /// supports build and test stage workflows.
    type: ?WorkflowType,

    /// The version of the workflow.
    version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .change_description = "changeDescription",
        .date_created = "dateCreated",
        .description = "description",
        .name = "name",
        .owner = "owner",
        .state = "state",
        .tags = "tags",
        .type = "type",
        .version = "version",
    };
};
