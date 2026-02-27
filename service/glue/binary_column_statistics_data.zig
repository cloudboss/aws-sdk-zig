/// Defines column statistics supported for bit sequence data values.
pub const BinaryColumnStatisticsData = struct {
    /// The average bit sequence length in the column.
    average_length: f64 = 0,

    /// The size of the longest bit sequence in the column.
    maximum_length: i64 = 0,

    /// The number of null values in the column.
    number_of_nulls: i64 = 0,

    pub const json_field_names = .{
        .average_length = "AverageLength",
        .maximum_length = "MaximumLength",
        .number_of_nulls = "NumberOfNulls",
    };
};
