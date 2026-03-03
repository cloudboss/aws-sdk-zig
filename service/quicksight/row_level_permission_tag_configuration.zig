const Status = @import("status.zig").Status;
const RowLevelPermissionTagRule = @import("row_level_permission_tag_rule.zig").RowLevelPermissionTagRule;

/// The configuration of tags on a dataset to set row-level security.
pub const RowLevelPermissionTagConfiguration = struct {
    /// The status of row-level security tags. If enabled, the status is `ENABLED`.
    /// If disabled, the status is `DISABLED`.
    status: ?Status = null,

    /// A list of tag configuration rules to apply to a dataset. All tag
    /// configurations have the OR condition. Tags within each tile will be joined
    /// (AND). At least one rule in this structure must have all tag values assigned
    /// to it to apply Row-level security (RLS) to the dataset.
    tag_rule_configurations: ?[]const []const []const u8 = null,

    /// A set of rules associated with row-level security, such as the tag names and
    /// columns that they are assigned to.
    tag_rules: []const RowLevelPermissionTagRule,

    pub const json_field_names = .{
        .status = "Status",
        .tag_rule_configurations = "TagRuleConfigurations",
        .tag_rules = "TagRules",
    };
};
