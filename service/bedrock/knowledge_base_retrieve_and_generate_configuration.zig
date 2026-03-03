const GenerationConfiguration = @import("generation_configuration.zig").GenerationConfiguration;
const OrchestrationConfiguration = @import("orchestration_configuration.zig").OrchestrationConfiguration;
const KnowledgeBaseRetrievalConfiguration = @import("knowledge_base_retrieval_configuration.zig").KnowledgeBaseRetrievalConfiguration;

/// Contains configuration details for retrieving information from a knowledge
/// base and generating responses.
pub const KnowledgeBaseRetrieveAndGenerateConfiguration = struct {
    /// Contains configurations details for response generation based on retrieved
    /// text chunks.
    generation_configuration: ?GenerationConfiguration = null,

    /// The unique identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The Amazon Resource Name (ARN) of the foundation model or [inference
    /// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) used to generate responses.
    model_arn: []const u8,

    /// Contains configuration details for the model to process the prompt prior to
    /// retrieval and response generation.
    orchestration_configuration: ?OrchestrationConfiguration = null,

    /// Contains configuration details for retrieving text chunks.
    retrieval_configuration: ?KnowledgeBaseRetrievalConfiguration = null,

    pub const json_field_names = .{
        .generation_configuration = "generationConfiguration",
        .knowledge_base_id = "knowledgeBaseId",
        .model_arn = "modelArn",
        .orchestration_configuration = "orchestrationConfiguration",
        .retrieval_configuration = "retrievalConfiguration",
    };
};
