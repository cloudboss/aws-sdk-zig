const RetrievalOverrides = @import("retrieval_overrides.zig").RetrievalOverrides;

/// Configuration for retrieving from a Bedrock knowledge base.
pub const KnowledgeBaseRetrieverConfiguration = struct {
    /// The unique identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// Overrides for retrieval behavior such as filters and result limits.
    retrieval_overrides: ?RetrievalOverrides = null,

    pub const json_field_names = .{
        .knowledge_base_id = "knowledgeBaseId",
        .retrieval_overrides = "retrievalOverrides",
    };
};
