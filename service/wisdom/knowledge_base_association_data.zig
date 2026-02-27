/// Association information about the knowledge base.
pub const KnowledgeBaseAssociationData = struct {
    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: ?[]const u8,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it.
    knowledge_base_id: ?[]const u8,

    pub const json_field_names = .{
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
    };
};
