const aws = @import("aws");

const ActionTarget = @import("action_target.zig").ActionTarget;

/// Provides a summary of an action.
pub const ActionSummary = struct {
    /// The Amazon Resource Name (ARN) of the action.
    arn: ?[]const u8 = null,

    /// The description for the action.
    description: ?[]const u8 = null,

    /// The ID of the action.
    id: ?[]const u8 = null,

    /// The tags for the action.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The targets for the action.
    targets: ?[]const aws.map.MapEntry(ActionTarget) = null,

    pub const json_field_names = .{
        .arn = "arn",
        .description = "description",
        .id = "id",
        .tags = "tags",
        .targets = "targets",
    };
};
