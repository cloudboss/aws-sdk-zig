const ErrorCode = @import("error_code.zig").ErrorCode;

/// Provides information about documents that could not be removed from an index
/// by the
/// `BatchDeleteDocument` API.
pub const BatchDeleteDocumentResponseFailedDocument = struct {
    /// The identifier of the data source connector that the document belongs to.
    data_source_id: ?[]const u8,

    /// The error code for why the document couldn't be removed from the index.
    error_code: ?ErrorCode,

    /// An explanation for why the document couldn't be removed from the index.
    error_message: ?[]const u8,

    /// The identifier of the document that couldn't be removed from the index.
    id: ?[]const u8,

    pub const json_field_names = .{
        .data_source_id = "DataSourceId",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .id = "Id",
    };
};
