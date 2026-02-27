/// Provides insights into the table with the most sub-optimal temporal pruning
/// scanned by your query.
pub const QueryTemporalRangeMax = struct {
    /// The Amazon Resource Name (ARN) of the table which is queried with the
    /// largest time range.
    table_arn: ?[]const u8,

    /// The maximum duration in nanoseconds between the start and end of the query.
    value: i64 = 0,

    pub const json_field_names = .{
        .table_arn = "TableArn",
        .value = "Value",
    };
};
