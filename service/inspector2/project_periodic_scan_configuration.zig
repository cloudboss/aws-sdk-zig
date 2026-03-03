const RuleSetCategory = @import("rule_set_category.zig").RuleSetCategory;

/// Contains the periodic scan configuration settings applied to a specific
/// project.
pub const ProjectPeriodicScanConfiguration = struct {
    /// The schedule expression for periodic scans, in cron format, applied to the
    /// project.
    frequency_expression: ?[]const u8 = null,

    /// The categories of security rules applied during periodic scans for the
    /// project.
    rule_set_categories: ?[]const RuleSetCategory = null,

    pub const json_field_names = .{
        .frequency_expression = "frequencyExpression",
        .rule_set_categories = "ruleSetCategories",
    };
};
