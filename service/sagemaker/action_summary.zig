const ActionSource = @import("action_source.zig").ActionSource;
const ActionStatus = @import("action_status.zig").ActionStatus;

/// Lists the properties of an *action*. An action represents an action or
/// activity. Some examples are a workflow step and a model deployment.
/// Generally, an action involves at least one input artifact or output
/// artifact.
pub const ActionSummary = struct {
    /// The Amazon Resource Name (ARN) of the action.
    action_arn: ?[]const u8 = null,

    /// The name of the action.
    action_name: ?[]const u8 = null,

    /// The type of the action.
    action_type: ?[]const u8 = null,

    /// When the action was created.
    creation_time: ?i64 = null,

    /// When the action was last modified.
    last_modified_time: ?i64 = null,

    /// The source of the action.
    source: ?ActionSource = null,

    /// The status of the action.
    status: ?ActionStatus = null,

    pub const json_field_names = .{
        .action_arn = "ActionArn",
        .action_name = "ActionName",
        .action_type = "ActionType",
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .source = "Source",
        .status = "Status",
    };
};
