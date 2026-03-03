const DataSourceErrorType = @import("data_source_error_type.zig").DataSourceErrorType;

/// The details of the error message that is returned if the operation cannot be
/// successfully completed.
pub const DataSourceErrorMessage = struct {
    /// The details of the error message that is returned if the operation cannot be
    /// successfully completed.
    error_detail: ?[]const u8 = null,

    /// The type of the error message that is returned if the operation cannot be
    /// successfully completed.
    error_type: DataSourceErrorType,

    pub const json_field_names = .{
        .error_detail = "errorDetail",
        .error_type = "errorType",
    };
};
