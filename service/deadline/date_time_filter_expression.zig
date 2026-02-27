const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;

/// The time stamp in date-time format.
pub const DateTimeFilterExpression = struct {
    /// The date and time.
    date_time: i64,

    /// The name of the date-time field to filter on.
    name: []const u8,

    /// The type of comparison to use to filter the results.
    operator: ComparisonOperator,

    pub const json_field_names = .{
        .date_time = "dateTime",
        .name = "name",
        .operator = "operator",
    };
};
