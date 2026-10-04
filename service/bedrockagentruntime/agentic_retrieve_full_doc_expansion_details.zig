const AgenticRetrieveSourceRetriever = @import("agentic_retrieve_source_retriever.zig").AgenticRetrieveSourceRetriever;

/// Details of a full document expansion action.
pub const AgenticRetrieveFullDocExpansionDetails = struct {
    /// The identifier of the document to expand.
    document_id: ?[]const u8 = null,

    /// The source retriever associated with the document.
    source_retriever: ?AgenticRetrieveSourceRetriever = null,

    pub const json_field_names = .{
        .document_id = "documentId",
        .source_retriever = "sourceRetriever",
    };
};
