const ExternalBedrockKnowledgeBaseConfig = @import("external_bedrock_knowledge_base_config.zig").ExternalBedrockKnowledgeBaseConfig;
const KnowledgeBaseAssociationData = @import("knowledge_base_association_data.zig").KnowledgeBaseAssociationData;

/// The data that is output as a result of the assistant association.
pub const AssistantAssociationOutputData = union(enum) {
    /// The configuration for an external Bedrock knowledge base association in the
    /// output data.
    external_bedrock_knowledge_base_config: ?ExternalBedrockKnowledgeBaseConfig,
    /// The knowledge base where output data is sent.
    knowledge_base_association: ?KnowledgeBaseAssociationData,

    pub const json_field_names = .{
        .external_bedrock_knowledge_base_config = "externalBedrockKnowledgeBaseConfig",
        .knowledge_base_association = "knowledgeBaseAssociation",
    };
};
