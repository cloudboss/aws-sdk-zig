const EvaluationPrecomputedRetrieveAndGenerateSourceConfig = @import("evaluation_precomputed_retrieve_and_generate_source_config.zig").EvaluationPrecomputedRetrieveAndGenerateSourceConfig;
const EvaluationPrecomputedRetrieveSourceConfig = @import("evaluation_precomputed_retrieve_source_config.zig").EvaluationPrecomputedRetrieveSourceConfig;

/// A summary of a RAG source used for a Knowledge Base evaluation job where you
/// provide your own inference response data.
pub const EvaluationPrecomputedRagSourceConfig = union(enum) {
    /// A summary of a RAG source used for a retrieve-and-generate Knowledge Base
    /// evaluation job where you provide your own inference response data.
    retrieve_and_generate_source_config: ?EvaluationPrecomputedRetrieveAndGenerateSourceConfig,
    /// A summary of a RAG source used for a retrieve-only Knowledge Base evaluation
    /// job where you provide your own inference response data.
    retrieve_source_config: ?EvaluationPrecomputedRetrieveSourceConfig,

    pub const json_field_names = .{
        .retrieve_and_generate_source_config = "retrieveAndGenerateSourceConfig",
        .retrieve_source_config = "retrieveSourceConfig",
    };
};
