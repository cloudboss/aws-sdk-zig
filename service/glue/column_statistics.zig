const ColumnStatisticsData = @import("column_statistics_data.zig").ColumnStatisticsData;

/// Represents the generated column-level statistics for a table or partition.
pub const ColumnStatistics = struct {
    /// The timestamp of when column statistics were generated.
    analyzed_time: i64,

    /// Name of column which statistics belong to.
    column_name: []const u8,

    /// The data type of the column.
    column_type: []const u8,

    /// A `ColumnStatisticData` object that contains the statistics data values.
    statistics_data: ColumnStatisticsData,

    pub const json_field_names = .{
        .analyzed_time = "AnalyzedTime",
        .column_name = "ColumnName",
        .column_type = "ColumnType",
        .statistics_data = "StatisticsData",
    };
};
