const KnowledgeBaseVectorSearchConfiguration = @import("knowledge_base_vector_search_configuration.zig").KnowledgeBaseVectorSearchConfiguration;

/// Contains configuration details for retrieving information from a knowledge
/// base.
pub const KnowledgeBaseRetrievalConfiguration = struct {
    /// Contains configuration details for returning the results from the vector
    /// search.
    vector_search_configuration: KnowledgeBaseVectorSearchConfiguration,

    pub const json_field_names = .{
        .vector_search_configuration = "vectorSearchConfiguration",
    };
};
