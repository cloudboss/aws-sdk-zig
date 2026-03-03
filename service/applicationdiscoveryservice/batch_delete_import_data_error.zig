const BatchDeleteImportDataErrorCode = @import("batch_delete_import_data_error_code.zig").BatchDeleteImportDataErrorCode;

/// Error messages returned for each import task that you deleted as a response
/// for this
/// command.
pub const BatchDeleteImportDataError = struct {
    /// The type of error that occurred for a specific import task.
    error_code: ?BatchDeleteImportDataErrorCode = null,

    /// The description of the error that occurred for a specific import task.
    error_description: ?[]const u8 = null,

    /// The unique import ID associated with the error that occurred.
    import_task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_description = "errorDescription",
        .import_task_id = "importTaskId",
    };
};
