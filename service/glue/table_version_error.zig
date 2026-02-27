const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// An error record for table-version operations.
pub const TableVersionError = struct {
    /// The details about the error.
    error_detail: ?ErrorDetail,

    /// The name of the table in question.
    table_name: ?[]const u8,

    /// The ID value of the version in question. A `VersionID` is a string
    /// representation of an integer. Each version is incremented by 1.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .error_detail = "ErrorDetail",
        .table_name = "TableName",
        .version_id = "VersionId",
    };
};
