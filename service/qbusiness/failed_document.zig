const ErrorDetail = @import("error_detail.zig").ErrorDetail;

/// A list of documents that could not be removed from an Amazon Q Business
/// index. Each entry contains an error message that indicates why the document
/// couldn't be removed from the index.
pub const FailedDocument = struct {
    /// The identifier of the Amazon Q Business data source connector that contains
    /// the failed document.
    data_source_id: ?[]const u8,

    /// An explanation for why the document couldn't be removed from the index.
    @"error": ?ErrorDetail,

    /// The identifier of the document that couldn't be removed from the Amazon Q
    /// Business index.
    id: ?[]const u8,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .@"error" = "error",
        .id = "id",
    };
};
