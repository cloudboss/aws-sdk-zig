const KnowledgeBaseVectorSearchConfiguration = @import("knowledge_base_vector_search_configuration.zig").KnowledgeBaseVectorSearchConfiguration;

/// Contains configurations for knowledge base query. For more information, see
/// [Query
/// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_RequestSyntax) – in the `retrievalConfiguration` field
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax) – in the `retrievalConfiguration` field
pub const KnowledgeBaseRetrievalConfiguration = struct {
    /// Contains details about how the results from the vector search should be
    /// returned. For more information, see [Query
    /// configurations](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-test-config.html).
    vector_search_configuration: KnowledgeBaseVectorSearchConfiguration,

    pub const json_field_names = .{
        .vector_search_configuration = "vectorSearchConfiguration",
    };
};
