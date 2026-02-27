/// An `ActionTarget` object.
pub const ActionTarget = struct {
    /// The ARN for the target action.
    action_target_arn: []const u8,

    /// The description of the target action.
    description: []const u8,

    /// The name of the action target.
    name: []const u8,

    pub const json_field_names = .{
        .action_target_arn = "ActionTargetArn",
        .description = "Description",
        .name = "Name",
    };
};
