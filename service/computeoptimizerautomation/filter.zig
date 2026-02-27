const AutomationRuleFilterName = @import("automation_rule_filter_name.zig").AutomationRuleFilterName;

/// A filter used to narrow down results based on specific criteria.
pub const Filter = struct {
    /// The name of the filter field to apply.
    name: AutomationRuleFilterName,

    /// The list of values to filter by for the specified filter field.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
