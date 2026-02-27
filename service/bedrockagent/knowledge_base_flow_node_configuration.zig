const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const PromptInferenceConfiguration = @import("prompt_inference_configuration.zig").PromptInferenceConfiguration;
const KnowledgeBaseOrchestrationConfiguration = @import("knowledge_base_orchestration_configuration.zig").KnowledgeBaseOrchestrationConfiguration;
const KnowledgeBasePromptTemplate = @import("knowledge_base_prompt_template.zig").KnowledgeBasePromptTemplate;
const VectorSearchRerankingConfiguration = @import("vector_search_reranking_configuration.zig").VectorSearchRerankingConfiguration;

/// Contains configurations for a knowledge base node in a flow. This node takes
/// a query as the input and returns, as the output, the retrieved responses
/// directly (as an array) or a response generated based on the retrieved
/// responses. For more information, see [Node types in a
/// flow](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-nodes.html)
/// in the Amazon Bedrock User Guide.
pub const KnowledgeBaseFlowNodeConfiguration = struct {
    /// Contains configurations for a guardrail to apply during query and response
    /// generation for the knowledge base in this configuration.
    guardrail_configuration: ?GuardrailConfiguration,

    /// Contains inference configurations for the prompt.
    inference_configuration: ?PromptInferenceConfiguration,

    /// The unique identifier of the knowledge base to query.
    knowledge_base_id: []const u8 = "",

    /// The unique identifier of the model or [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) to use to generate a response from the query results. Omit this field if you want to return the retrieved results as an array.
    model_id: ?[]const u8,

    /// The number of results to retrieve from the knowledge base.
    number_of_results: ?i32,

    /// The configuration for orchestrating the retrieval and generation process in
    /// the knowledge base node.
    orchestration_configuration: ?KnowledgeBaseOrchestrationConfiguration,

    /// A custom prompt template to use with the knowledge base for generating
    /// responses.
    prompt_template: ?KnowledgeBasePromptTemplate,

    /// The configuration for reranking the retrieved results from the knowledge
    /// base to improve relevance.
    reranking_configuration: ?VectorSearchRerankingConfiguration,

    pub const json_field_names = .{
        .guardrail_configuration = "guardrailConfiguration",
        .inference_configuration = "inferenceConfiguration",
        .knowledge_base_id = "knowledgeBaseId",
        .model_id = "modelId",
        .number_of_results = "numberOfResults",
        .orchestration_configuration = "orchestrationConfiguration",
        .prompt_template = "promptTemplate",
        .reranking_configuration = "rerankingConfiguration",
    };
};
