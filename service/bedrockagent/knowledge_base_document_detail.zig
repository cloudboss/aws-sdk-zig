const DocumentIdentifier = @import("document_identifier.zig").DocumentIdentifier;
const DocumentStatus = @import("document_status.zig").DocumentStatus;

/// Contains the details for a document that was ingested or deleted.
pub const KnowledgeBaseDocumentDetail = struct {
    /// The identifier of the data source connected to the knowledge base that the
    /// document was ingested into or deleted from.
    data_source_id: []const u8,

    /// Contains information that identifies the document.
    identifier: DocumentIdentifier,

    /// The identifier of the knowledge base that the document was ingested into or
    /// deleted from.
    knowledge_base_id: []const u8,

    /// The ingestion status of the document. The following statuses are possible:
    ///
    /// * STARTING – You submitted the ingestion job containing the document.
    /// * PENDING – The document is waiting to be ingested.
    /// * IN_PROGRESS – The document is being ingested.
    /// * INDEXED – The document was successfully indexed.
    /// * PARTIALLY_INDEXED – The document was partially indexed.
    /// * METADATA_PARTIALLY_INDEXED – You submitted metadata for an existing
    ///   document and it was partially indexed.
    /// * METADATA_UPDATE_FAILED – You submitted a metadata update for an existing
    ///   document but it failed.
    /// * FAILED – The document failed to be ingested.
    /// * NOT_FOUND – The document wasn't found.
    /// * IGNORED – The document was ignored during ingestion.
    /// * DELETING – You submitted the delete job containing the document.
    /// * DELETE_IN_PROGRESS – The document is being deleted.
    status: DocumentStatus,

    /// The reason for the status. Appears alongside the status `IGNORED`.
    status_reason: ?[]const u8,

    /// The date and time at which the document was last updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .identifier = "identifier",
        .knowledge_base_id = "knowledgeBaseId",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
