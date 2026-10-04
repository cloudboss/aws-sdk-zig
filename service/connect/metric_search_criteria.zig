const BooleanCondition = @import("boolean_condition.zig").BooleanCondition;
const StringCondition = @import("string_condition.zig").StringCondition;

/// Defines the search criteria for filtering metrics.
pub const MetricSearchCriteria = struct {
    /// A list of conditions that must all be satisfied.
    and_conditions: ?[]const MetricSearchCriteria = null,

    boolean_condition: ?BooleanCondition = null,

    /// A list of conditions to be met, where at least one condition must be
    /// satisfied.
    or_conditions: ?[]const MetricSearchCriteria = null,

    string_condition: ?StringCondition = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .boolean_condition = "BooleanCondition",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
