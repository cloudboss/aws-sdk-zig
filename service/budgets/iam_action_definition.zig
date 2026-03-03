/// The Identity and Access Management (IAM) action definition details.
pub const IamActionDefinition = struct {
    /// A list of groups to be attached. There must be at least one group.
    groups: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the policy to be attached.
    policy_arn: []const u8,

    /// A list of roles to be attached. There must be at least one role.
    roles: ?[]const []const u8 = null,

    /// A list of users to be attached. There must be at least one user.
    users: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .groups = "Groups",
        .policy_arn = "PolicyArn",
        .roles = "Roles",
        .users = "Users",
    };
};
