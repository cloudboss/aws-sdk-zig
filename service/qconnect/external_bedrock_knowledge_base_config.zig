/// Configuration for an external Bedrock knowledge base.
pub const ExternalBedrockKnowledgeBaseConfig = struct {
    /// The Amazon Resource Name (ARN) of the IAM role used to access the external
    /// Bedrock knowledge base.
    access_role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the external Bedrock knowledge base.
    bedrock_knowledge_base_arn: []const u8,

    pub const json_field_names = .{
        .access_role_arn = "accessRoleArn",
        .bedrock_knowledge_base_arn = "bedrockKnowledgeBaseArn",
    };
};
