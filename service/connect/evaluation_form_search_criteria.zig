const BooleanCondition = @import("boolean_condition.zig").BooleanCondition;
const DateTimeCondition = @import("date_time_condition.zig").DateTimeCondition;
const NumberCondition = @import("number_condition.zig").NumberCondition;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return evaluation forms.
pub const EvaluationFormSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const EvaluationFormSearchCriteria = null,

    /// Boolean search condition.
    boolean_condition: ?BooleanCondition = null,

    /// Datetime search condition.
    date_time_condition: ?DateTimeCondition = null,

    number_condition: ?NumberCondition = null,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const EvaluationFormSearchCriteria = null,

    string_condition: ?StringCondition = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .boolean_condition = "BooleanCondition",
        .date_time_condition = "DateTimeCondition",
        .number_condition = "NumberCondition",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
