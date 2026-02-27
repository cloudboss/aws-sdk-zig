const BooleanCondition = @import("boolean_condition.zig").BooleanCondition;
const DateTimeCondition = @import("date_time_condition.zig").DateTimeCondition;
const DecimalCondition = @import("decimal_condition.zig").DecimalCondition;
const NumberCondition = @import("number_condition.zig").NumberCondition;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return evaluations.
pub const EvaluationSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const EvaluationSearchCriteria,

    /// The boolean condition search criteria for searching evaluations.
    boolean_condition: ?BooleanCondition,

    /// The datetime condition search criteria for searching evaluations.
    date_time_condition: ?DateTimeCondition,

    /// The decimal condition search criteria for searching evaluations.
    decimal_condition: ?DecimalCondition,

    number_condition: ?NumberCondition,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const EvaluationSearchCriteria,

    string_condition: ?StringCondition,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .boolean_condition = "BooleanCondition",
        .date_time_condition = "DateTimeCondition",
        .decimal_condition = "DecimalCondition",
        .number_condition = "NumberCondition",
        .or_conditions = "OrConditions",
        .string_condition = "StringCondition",
    };
};
