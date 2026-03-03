const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// An error record for table operations.
pub const TableError = struct {
    /// The details about the error.
    error_detail: ?ErrorDetail = null,

    /// The name of the table. For Hive compatibility, this must be entirely
    /// lowercase.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_detail = "ErrorDetail",
        .table_name = "TableName",
    };
};
