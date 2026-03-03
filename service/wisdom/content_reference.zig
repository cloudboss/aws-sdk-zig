/// Reference information about the content.
pub const ContentReference = struct {
    /// The Amazon Resource Name (ARN) of the content.
    content_arn: ?[]const u8 = null,

    /// The identifier of the content.
    content_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: ?[]const u8 = null,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it.
    knowledge_base_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_arn = "contentArn",
        .content_id = "contentId",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
    };
};
