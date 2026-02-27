const EvaluationModelConfig = @import("evaluation_model_config.zig").EvaluationModelConfig;
const RAGConfig = @import("rag_config.zig").RAGConfig;

/// The configuration details of the inference model for an evaluation job.
///
/// For automated model evaluation jobs, only a single model is supported.
///
/// For human-based model evaluation jobs, your annotator can compare the
/// responses for up to two different models.
pub const EvaluationInferenceConfig = union(enum) {
    /// Specifies the inference models.
    models: ?[]const EvaluationModelConfig,
    /// Contains the configuration details of the inference for a knowledge base
    /// evaluation job, including either the retrieval only configuration or the
    /// retrieval with response generation configuration.
    rag_configs: ?[]const RAGConfig,

    pub const json_field_names = .{
        .models = "models",
        .rag_configs = "ragConfigs",
    };
};
