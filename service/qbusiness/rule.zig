const UsersAndGroups = @import("users_and_groups.zig").UsersAndGroups;
const RuleConfiguration = @import("rule_configuration.zig").RuleConfiguration;
const RuleType = @import("rule_type.zig").RuleType;

/// Guardrail rules for an Amazon Q Business application. Amazon Q Business
/// supports only one rule at a time.
pub const Rule = struct {
    /// Users and groups to be excluded from a rule.
    excluded_users_and_groups: ?UsersAndGroups,

    /// Users and groups to be included in a rule.
    included_users_and_groups: ?UsersAndGroups,

    /// The configuration information for a rule.
    rule_configuration: ?RuleConfiguration,

    /// The type of rule.
    rule_type: RuleType,

    pub const json_field_names = .{
        .excluded_users_and_groups = "excludedUsersAndGroups",
        .included_users_and_groups = "includedUsersAndGroups",
        .rule_configuration = "ruleConfiguration",
        .rule_type = "ruleType",
    };
};
