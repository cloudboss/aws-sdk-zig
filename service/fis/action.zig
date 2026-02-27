const aws = @import("aws");

const ActionParameter = @import("action_parameter.zig").ActionParameter;
const ActionTarget = @import("action_target.zig").ActionTarget;

/// Describes an action. For more information, see [FIS
/// actions](https://docs.aws.amazon.com/fis/latest/userguide/fis-actions-reference.html)
/// in the *Fault Injection Service User Guide*.
pub const Action = struct {
    /// The Amazon Resource Name (ARN) of the action.
    arn: ?[]const u8,

    /// The description for the action.
    description: ?[]const u8,

    /// The ID of the action.
    id: ?[]const u8,

    /// The action parameters, if applicable.
    parameters: ?[]const aws.map.MapEntry(ActionParameter),

    /// The tags for the action.
    tags: ?[]const aws.map.StringMapEntry,

    /// The supported targets for the action.
    targets: ?[]const aws.map.MapEntry(ActionTarget),

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .id = "id",
        .parameters = "parameters",
        .tags = "tags",
        .targets = "targets",
    };
};
