/// Contains configurations for a knowledge base to use in transformation.
pub const TextToSqlKnowledgeBaseConfiguration = struct {
    /// The ARN of the knowledge base
    knowledge_base_arn: []const u8,

    pub const json_field_names = .{
        .knowledge_base_arn = "knowledgeBaseArn",
    };
};
