const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return security profiles.
///
/// The `name` field support "contains" queries with a minimum of 2 characters
/// and maximum of 25
/// characters. Any queries with character lengths outside of this range will
/// throw invalid
/// results.
pub const SecurityProfileSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const SecurityProfileSearchCriteria = null,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const SecurityProfileSearchCriteria = null,

    string_condition: ?StringCondition = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
