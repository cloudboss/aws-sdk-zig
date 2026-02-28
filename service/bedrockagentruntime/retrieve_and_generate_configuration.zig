const ExternalSourcesRetrieveAndGenerateConfiguration = @import("external_sources_retrieve_and_generate_configuration.zig").ExternalSourcesRetrieveAndGenerateConfiguration;
const KnowledgeBaseRetrieveAndGenerateConfiguration = @import("knowledge_base_retrieve_and_generate_configuration.zig").KnowledgeBaseRetrieveAndGenerateConfiguration;
const RetrieveAndGenerateType = @import("retrieve_and_generate_type.zig").RetrieveAndGenerateType;

/// Contains details about the resource being queried.
///
/// This data type is used in the following API operations:
///
/// * [RetrieveAndGenerate
///   request](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_RequestSyntax) – in the `retrieveAndGenerateConfiguration` field
pub const RetrieveAndGenerateConfiguration = struct {
    /// The configuration for the external source wrapper object in the
    /// `retrieveAndGenerate` function.
    external_sources_configuration: ?ExternalSourcesRetrieveAndGenerateConfiguration,

    /// Contains details about the knowledge base for retrieving information and
    /// generating responses.
    knowledge_base_configuration: ?KnowledgeBaseRetrieveAndGenerateConfiguration,

    /// The type of resource that contains your data for retrieving information and
    /// generating responses.
    ///
    /// If you choose to use `EXTERNAL_SOURCES`, then currently only Anthropic
    /// Claude 3 Sonnet models for knowledge bases are supported.
    type: RetrieveAndGenerateType,

    pub const json_field_names = .{
        .external_sources_configuration = "externalSourcesConfiguration",
        .knowledge_base_configuration = "knowledgeBaseConfiguration",
        .type = "type",
    };
};
