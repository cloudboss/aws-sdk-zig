/// A summary of a RAG source used for a retrieve-and-generate Knowledge Base
/// evaluation job where you provide your own inference response data.
pub const EvaluationPrecomputedRetrieveAndGenerateSourceConfig = struct {
    /// A label that identifies the RAG source used for a retrieve-and-generate
    /// Knowledge Base evaluation job where you provide your own inference response
    /// data.
    rag_source_identifier: []const u8,

    pub const json_field_names = .{
        .rag_source_identifier = "ragSourceIdentifier",
    };
};
