/// Association information about the knowledge base.
pub const KnowledgeBaseAssociationData = struct {
    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: ?[]const u8 = null,

    /// The identifier of the knowledge base.
    knowledge_base_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
    };
};
