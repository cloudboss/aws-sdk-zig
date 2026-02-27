/// Defines column statistics supported for Boolean data columns.
pub const BooleanColumnStatisticsData = struct {
    /// The number of false values in the column.
    number_of_falses: i64 = 0,

    /// The number of null values in the column.
    number_of_nulls: i64 = 0,

    /// The number of true values in the column.
    number_of_trues: i64 = 0,

    pub const json_field_names = .{
        .number_of_falses = "NumberOfFalses",
        .number_of_nulls = "NumberOfNulls",
        .number_of_trues = "NumberOfTrues",
    };
};
