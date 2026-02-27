const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const DocumentStatus = @import("document_status.zig").DocumentStatus;

/// The details of a document within an Amazon Q Business index.
pub const DocumentDetails = struct {
    /// The timestamp for when the document was created.
    created_at: ?i64,

    /// The identifier of the document.
    document_id: ?[]const u8,

    /// An error message associated with the document.
    @"error": ?ErrorDetail,

    /// The current status of the document.
    status: ?DocumentStatus,

    /// The timestamp for when the document was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .document_id = "documentId",
        .@"error" = "error",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
