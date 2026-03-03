const ErrorCode = @import("error_code.zig").ErrorCode;

/// Provides a response when the status of a document could not be retrieved.
pub const BatchGetDocumentStatusResponseError = struct {
    /// The identifier of the data source connector that the failed document belongs
    /// to.
    data_source_id: ?[]const u8 = null,

    /// The identifier of the document whose status could not be retrieved.
    document_id: ?[]const u8 = null,

    /// Indicates the source of the error.
    error_code: ?ErrorCode = null,

    /// States that the API could not get the status of a document. This could be
    /// because the
    /// request is not valid or there is a system error.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .document_id = "DocumentId",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
