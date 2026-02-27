const ExternalBedrockKnowledgeBaseConfig = @import("external_bedrock_knowledge_base_config.zig").ExternalBedrockKnowledgeBaseConfig;

/// The data that is input into Amazon Q in Connect as a result of the assistant
/// association.
pub const AssistantAssociationInputData = union(enum) {
    /// The configuration for an external Bedrock knowledge base association.
    external_bedrock_knowledge_base_config: ?ExternalBedrockKnowledgeBaseConfig,
    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge base.
    knowledge_base_id: ?[]const u8,

    pub const json_field_names = .{
        .external_bedrock_knowledge_base_config = "externalBedrockKnowledgeBaseConfig",
        .knowledge_base_id = "knowledgeBaseId",
    };
};
