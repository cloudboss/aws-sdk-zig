const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// Encapsulates a column name that failed and the reason for failure.
pub const ColumnError = struct {
    /// The name of the column that failed.
    column_name: ?[]const u8,

    /// An error message with the reason for the failure of an operation.
    @"error": ?ErrorDetail,

    pub const json_field_names = .{
        .column_name = "ColumnName",
        .@"error" = "Error",
    };
};
