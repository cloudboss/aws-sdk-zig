/// Defines column statistics supported for character sequence data values.
pub const StringColumnStatisticsData = struct {
    /// The average string length in the column.
    average_length: f64 = 0,

    /// The size of the longest string in the column.
    maximum_length: i64 = 0,

    /// The number of distinct values in a column.
    number_of_distinct_values: i64 = 0,

    /// The number of null values in the column.
    number_of_nulls: i64 = 0,

    pub const json_field_names = .{
        .average_length = "AverageLength",
        .maximum_length = "MaximumLength",
        .number_of_distinct_values = "NumberOfDistinctValues",
        .number_of_nulls = "NumberOfNulls",
    };
};
