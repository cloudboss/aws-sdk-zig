const DateCondition = @import("date_condition.zig").DateCondition;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return hours of operations overrides.
pub const HoursOfOperationOverrideSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const HoursOfOperationOverrideSearchCriteria,

    /// A leaf node condition which can be used to specify a date condition.
    date_condition: ?DateCondition,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const HoursOfOperationOverrideSearchCriteria,

    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .date_condition = "DateCondition",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
