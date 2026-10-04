/// Information about a knowledge base that was successfully deleted in a batch
/// operation.
pub const BatchDeleteKnowledgeBaseSuccess = struct {
    /// The ARN of the successfully deleted knowledge base.
    knowledge_base_arn: []const u8,

    /// The unique identifier of the successfully deleted knowledge base.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .knowledge_base_arn = "KnowledgeBaseArn",
        .knowledge_base_id = "KnowledgeBaseId",
    };
};
