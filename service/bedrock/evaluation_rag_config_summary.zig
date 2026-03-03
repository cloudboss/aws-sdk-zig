/// A summary of the RAG resources used in an Amazon Bedrock Knowledge Base
/// evaluation job. These resources can be Knowledge Bases in Amazon Bedrock or
/// RAG sources outside of Amazon Bedrock that you use to generate your own
/// inference response data.
pub const EvaluationRagConfigSummary = struct {
    /// The Amazon Resource Names (ARNs) of the Knowledge Base resources used for a
    /// Knowledge Base evaluation job where Amazon Bedrock invokes the Knowledge
    /// Base for you.
    bedrock_knowledge_base_identifiers: ?[]const []const u8 = null,

    /// A label that identifies the RAG sources used for a Knowledge Base evaluation
    /// job where you provide your own inference response data.
    precomputed_rag_source_identifiers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .bedrock_knowledge_base_identifiers = "bedrockKnowledgeBaseIdentifiers",
        .precomputed_rag_source_identifiers = "precomputedRagSourceIdentifiers",
    };
};
