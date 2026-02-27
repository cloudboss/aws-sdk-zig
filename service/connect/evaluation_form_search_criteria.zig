const BooleanCondition = @import("boolean_condition.zig").BooleanCondition;
const DateTimeCondition = @import("date_time_condition.zig").DateTimeCondition;
const NumberCondition = @import("number_condition.zig").NumberCondition;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return evaluation forms.
pub const EvaluationFormSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const EvaluationFormSearchCriteria,

    /// Boolean search condition.
    boolean_condition: ?BooleanCondition,

    /// Datetime search condition.
    date_time_condition: ?DateTimeCondition,

    number_condition: ?NumberCondition,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const EvaluationFormSearchCriteria,

    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .boolean_condition = "BooleanCondition",
        .date_time_condition = "DateTimeCondition",
        .number_condition = "NumberCondition",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
