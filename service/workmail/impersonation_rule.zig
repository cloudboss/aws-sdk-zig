const AccessEffect = @import("access_effect.zig").AccessEffect;

/// The rules for the given impersonation role.
pub const ImpersonationRule = struct {
    /// The rule description.
    description: ?[]const u8 = null,

    /// The effect of the rule when it matches the input. Allowed effect values are
    /// `ALLOW` or `DENY`.
    effect: AccessEffect,

    /// The identifier of the rule.
    impersonation_rule_id: []const u8,

    /// The rule name.
    name: ?[]const u8 = null,

    /// A list of user IDs that don't match the rule.
    not_target_users: ?[]const []const u8 = null,

    /// A list of user IDs that match the rule.
    target_users: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .effect = "Effect",
        .impersonation_rule_id = "ImpersonationRuleId",
        .name = "Name",
        .not_target_users = "NotTargetUsers",
        .target_users = "TargetUsers",
    };
};
