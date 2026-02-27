const StringCondition = @import("string_condition.zig").StringCondition;

/// A data table search criteria.
pub const DataTableSearchCriteria = struct {
    /// The criteria's and conditions.
    and_conditions: ?[]const DataTableSearchCriteria,

    /// The criteria's or conditions.
    or_conditions: ?[]const DataTableSearchCriteria,

    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
