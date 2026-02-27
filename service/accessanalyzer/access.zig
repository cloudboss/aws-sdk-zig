/// Contains information about actions and resources that define permissions to
/// check against a policy.
pub const Access = struct {
    /// A list of actions for the access permissions. Any strings that can be used
    /// as an action in an IAM policy can be used in the list of actions to check.
    actions: []const []const u8 = &.{},

    /// A list of resources for the access permissions. Any strings that can be used
    /// as an Amazon Resource Name (ARN) in an IAM policy can be used in the list of
    /// resources to check. You can only use a wildcard in the portion of the ARN
    /// that specifies the resource ID.
    resources: []const []const u8 = &.{},

    pub const json_field_names = .{
        .actions = "actions",
        .resources = "resources",
    };
};
