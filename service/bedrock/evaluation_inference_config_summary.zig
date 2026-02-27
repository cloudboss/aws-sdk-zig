const EvaluationModelConfigSummary = @import("evaluation_model_config_summary.zig").EvaluationModelConfigSummary;
const EvaluationRagConfigSummary = @import("evaluation_rag_config_summary.zig").EvaluationRagConfigSummary;

/// Identifies the models, Knowledge Bases, or other RAG sources evaluated in a
/// model or Knowledge Base evaluation job.
pub const EvaluationInferenceConfigSummary = struct {
    /// A summary of the models used in an Amazon Bedrock model evaluation job.
    /// These resources can be models in Amazon Bedrock or models outside of Amazon
    /// Bedrock that you use to generate your own inference response data.
    model_config_summary: ?EvaluationModelConfigSummary,

    /// A summary of the RAG resources used in an Amazon Bedrock Knowledge Base
    /// evaluation job. These resources can be Knowledge Bases in Amazon Bedrock or
    /// RAG sources outside of Amazon Bedrock that you use to generate your own
    /// inference response data.
    rag_config_summary: ?EvaluationRagConfigSummary,

    pub const json_field_names = .{
        .model_config_summary = "modelConfigSummary",
        .rag_config_summary = "ragConfigSummary",
    };
};
