const ColumnStatistics = @import("column_statistics.zig").ColumnStatistics;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// Encapsulates a `ColumnStatistics` object that failed and the reason for
/// failure.
pub const ColumnStatisticsError = struct {
    /// The `ColumnStatistics` of the column.
    column_statistics: ?ColumnStatistics,

    /// An error message with the reason for the failure of an operation.
    @"error": ?ErrorDetail,

    pub const json_field_names = .{
        .column_statistics = "ColumnStatistics",
        .@"error" = "Error",
    };
};
