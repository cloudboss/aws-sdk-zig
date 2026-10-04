const FoundationModelConfiguration = @import("foundation_model_configuration.zig").FoundationModelConfiguration;
const FoundationModelType = @import("foundation_model_type.zig").FoundationModelType;
const AgenticRetrieveRerankingConfiguration = @import("agentic_retrieve_reranking_configuration.zig").AgenticRetrieveRerankingConfiguration;
const AgenticRetrieveRerankingModelType = @import("agentic_retrieve_reranking_model_type.zig").AgenticRetrieveRerankingModelType;

/// Configuration settings for the agentic retrieval operation.
pub const AgenticRetrieveConfiguration = struct {
    /// The foundation model configuration. Required when foundationModelType is
    /// CUSTOM.
    foundation_model_configuration: ?FoundationModelConfiguration = null,

    /// The type of foundation model to use. CUSTOM uses a specified model, MANAGED
    /// uses the service default.
    foundation_model_type: FoundationModelType = .managed,

    /// The maximum number of agent iterations for retrieval.
    max_agent_iteration: i32 = 5,

    /// The reranking model configuration. Required when rerankingModelType is
    /// CUSTOM.
    reranking_configuration: ?AgenticRetrieveRerankingConfiguration = null,

    /// The type of reranking model to use. CUSTOM uses a specified model, MANAGED
    /// uses the service default. If not specified, defaults to MANAGED for managed
    /// embedding knowledge bases and NONE for custom embedding knowledge bases.
    reranking_model_type: ?AgenticRetrieveRerankingModelType = null,

    pub const json_field_names = .{
        .foundation_model_configuration = "foundationModelConfiguration",
        .foundation_model_type = "foundationModelType",
        .max_agent_iteration = "maxAgentIteration",
        .reranking_configuration = "rerankingConfiguration",
        .reranking_model_type = "rerankingModelType",
    };
};
