const DocumentStatus = @import("document_status.zig").DocumentStatus;

/// Provides information about the status of documents submitted for indexing.
pub const Status = struct {
    /// The identifier of the document.
    document_id: ?[]const u8 = null,

    /// The current status of a document.
    ///
    /// If the document was submitted for deletion, the status is `NOT_FOUND` after
    /// the document is deleted.
    document_status: ?DocumentStatus = null,

    /// Indicates the source of the error.
    failure_code: ?[]const u8 = null,

    /// Provides detailed information about why the document couldn't be indexed.
    /// Use this
    /// information to correct the error before you resubmit the document for
    /// indexing.
    failure_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_id = "DocumentId",
        .document_status = "DocumentStatus",
        .failure_code = "FailureCode",
        .failure_reason = "FailureReason",
    };
};
