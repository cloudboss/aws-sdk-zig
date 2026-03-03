const DecimalNumber = @import("decimal_number.zig").DecimalNumber;

/// Defines column statistics supported for fixed-point number data columns.
pub const DecimalColumnStatisticsData = struct {
    /// The highest value in the column.
    maximum_value: ?DecimalNumber = null,

    /// The lowest value in the column.
    minimum_value: ?DecimalNumber = null,

    /// The number of distinct values in a column.
    number_of_distinct_values: i64 = 0,

    /// The number of null values in the column.
    number_of_nulls: i64 = 0,

    pub const json_field_names = .{
        .maximum_value = "MaximumValue",
        .minimum_value = "MinimumValue",
        .number_of_distinct_values = "NumberOfDistinctValues",
        .number_of_nulls = "NumberOfNulls",
    };
};
