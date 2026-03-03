const GenerationConfiguration = @import("generation_configuration.zig").GenerationConfiguration;
const OrchestrationConfiguration = @import("orchestration_configuration.zig").OrchestrationConfiguration;
const KnowledgeBaseRetrievalConfiguration = @import("knowledge_base_retrieval_configuration.zig").KnowledgeBaseRetrievalConfiguration;

/// Contains details about the resource being queried.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_RequestSyntax) – in the `knowledgeBaseConfiguration` field
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax) – in the `knowledgeBaseConfiguration` field
pub const KnowledgeBaseRetrieveAndGenerateConfiguration = struct {
    /// Contains configurations for response generation based on the knowledge base
    /// query results.
    generation_configuration: ?GenerationConfiguration = null,

    /// The unique identifier of the knowledge base that is queried.
    knowledge_base_id: []const u8,

    /// The ARN of the foundation model or [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) used to generate a response.
    model_arn: []const u8,

    /// Settings for how the model processes the prompt prior to retrieval and
    /// generation.
    orchestration_configuration: ?OrchestrationConfiguration = null,

    /// Contains configurations for how to retrieve and return the knowledge base
    /// query.
    retrieval_configuration: ?KnowledgeBaseRetrievalConfiguration = null,

    pub const json_field_names = .{
        .generation_configuration = "generationConfiguration",
        .knowledge_base_id = "knowledgeBaseId",
        .model_arn = "modelArn",
        .orchestration_configuration = "orchestrationConfiguration",
        .retrieval_configuration = "retrievalConfiguration",
    };
};
