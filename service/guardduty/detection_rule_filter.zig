const DetectionRuleFilterCondition = @import("detection_rule_filter_condition.zig").DetectionRuleFilterCondition;
const FilterFieldName = @import("filter_field_name.zig").FilterFieldName;

/// Contains filter criteria for listing custom detection rules or associations.
pub const DetectionRuleFilter = struct {
    /// The condition to apply to the filter. For example, `EQUALS` or `CONTAINS`.
    condition: ?DetectionRuleFilterCondition = null,

    /// The name of the field to filter by.
    name: FilterFieldName,

    /// The values to match against the specified filter name.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition = "Condition",
        .name = "Name",
        .values = "Values",
    };
};
