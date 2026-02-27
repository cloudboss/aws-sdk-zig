const FilterConditionString = @import("filter_condition_string.zig").FilterConditionString;

/// Describes a filter for choosing a subset of objects. Each filter consists of
/// a
/// condition and a match statement. The condition is either `IS` or
/// `IS_NOT`, which specifies whether to include or exclude
/// the objects that match the statement, respectively. The match statement
/// consists of a key and a
/// value.
pub const Filter = struct {
    /// The condition to apply. To include the objects that match the statement,
    /// specify
    /// `IS`. To exclude matching objects, specify `IS_NOT`.
    condition: FilterConditionString,

    /// The name of the parameter to filter on.
    key: []const u8,

    /// The value to match.
    value: []const u8,

    pub const json_field_names = .{
        .condition = "Condition",
        .key = "Key",
        .value = "Value",
    };
};
