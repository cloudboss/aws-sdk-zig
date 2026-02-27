const ErrorCode = @import("error_code.zig").ErrorCode;

/// Provides information about a document that could not be indexed.
pub const BatchPutDocumentResponseFailedDocument = struct {
    /// The identifier of the data source connector that the failed document belongs
    /// to.
    data_source_id: ?[]const u8,

    /// The type of error that caused the document to fail to be indexed.
    error_code: ?ErrorCode,

    /// A description of the reason why the document could not be indexed.
    error_message: ?[]const u8,

    /// The identifier of the document.
    id: ?[]const u8,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .id = "Id",
    };
};
