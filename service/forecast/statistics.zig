/// Provides statistics for each data field imported into to an Amazon Forecast
/// dataset with
/// the
/// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html) operation.
pub const Statistics = struct {
    /// For a numeric field, the average value in the field.
    avg: ?f64,

    /// The number of values in the field. If the response value is -1, refer to
    /// `CountLong`.
    count: ?i32,

    /// The number of distinct values in the field. If the response value is -1,
    /// refer to
    /// `CountDistinctLong`.
    count_distinct: ?i32,

    /// The number of distinct values in the field. `CountDistinctLong` is used
    /// instead
    /// of `CountDistinct` if the value is greater than 2,147,483,647.
    count_distinct_long: ?i64,

    /// The number of values in the field. `CountLong` is used instead of
    /// `Count` if the value is greater than 2,147,483,647.
    count_long: ?i64,

    /// The number of NAN (not a number) values in the field. If the response value
    /// is -1, refer
    /// to `CountNanLong`.
    count_nan: ?i32,

    /// The number of NAN (not a number) values in the field. `CountNanLong` is used
    /// instead of `CountNan` if the value is greater than 2,147,483,647.
    count_nan_long: ?i64,

    /// The number of null values in the field. If the response value is -1, refer
    /// to
    /// `CountNullLong`.
    count_null: ?i32,

    /// The number of null values in the field. `CountNullLong` is used instead of
    /// `CountNull` if the value is greater than 2,147,483,647.
    count_null_long: ?i64,

    /// For a numeric field, the maximum value in the field.
    max: ?[]const u8,

    /// For a numeric field, the minimum value in the field.
    min: ?[]const u8,

    /// For a numeric field, the standard deviation.
    stddev: ?f64,

    pub const json_field_names = .{
        .avg = "Avg",
        .count = "Count",
        .count_distinct = "CountDistinct",
        .count_distinct_long = "CountDistinctLong",
        .count_long = "CountLong",
        .count_nan = "CountNan",
        .count_nan_long = "CountNanLong",
        .count_null = "CountNull",
        .count_null_long = "CountNullLong",
        .max = "Max",
        .min = "Min",
        .stddev = "Stddev",
    };
};
