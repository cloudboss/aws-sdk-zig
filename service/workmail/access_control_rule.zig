const AccessControlRuleEffect = @import("access_control_rule_effect.zig").AccessControlRuleEffect;

/// A rule that controls access to an WorkMail organization.
pub const AccessControlRule = struct {
    /// Access protocol actions to include in the rule. Valid values include
    /// `ActiveSync`, `AutoDiscover`, `EWS`, `IMAP`,
    /// `SMTP`, `WindowsOutlook`, and `WebMail`.
    actions: ?[]const []const u8 = null,

    /// The date that the rule was created.
    date_created: ?i64 = null,

    /// The date that the rule was modified.
    date_modified: ?i64 = null,

    /// The rule description.
    description: ?[]const u8 = null,

    /// The rule effect.
    effect: ?AccessControlRuleEffect = null,

    /// Impersonation role IDs to include in the rule.
    impersonation_role_ids: ?[]const []const u8 = null,

    /// IPv4 CIDR ranges to include in the rule.
    ip_ranges: ?[]const []const u8 = null,

    /// The rule name.
    name: ?[]const u8 = null,

    /// Access protocol actions to exclude from the rule. Valid values include
    /// `ActiveSync`, `AutoDiscover`, `EWS`, `IMAP`,
    /// `SMTP`, `WindowsOutlook`, and `WebMail`.
    not_actions: ?[]const []const u8 = null,

    /// Impersonation role IDs to exclude from the rule.
    not_impersonation_role_ids: ?[]const []const u8 = null,

    /// IPv4 CIDR ranges to exclude from the rule.
    not_ip_ranges: ?[]const []const u8 = null,

    /// User IDs to exclude from the rule.
    not_user_ids: ?[]const []const u8 = null,

    /// User IDs to include in the rule.
    user_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .description = "Description",
        .effect = "Effect",
        .impersonation_role_ids = "ImpersonationRoleIds",
        .ip_ranges = "IpRanges",
        .name = "Name",
        .not_actions = "NotActions",
        .not_impersonation_role_ids = "NotImpersonationRoleIds",
        .not_ip_ranges = "NotIpRanges",
        .not_user_ids = "NotUserIds",
        .user_ids = "UserIds",
    };
};
