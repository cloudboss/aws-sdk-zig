/// A citation that spans a specific range of text.
pub const SpanCitation = struct {
    /// The identifier of the content being cited in the span.
    content_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the knowledge base containing the cited
    /// content.
    knowledge_base_arn: ?[]const u8,

    /// The identifier of the knowledge base containing the cited content.
    knowledge_base_id: ?[]const u8,

    /// The title of the content being cited in the span.
    title: ?[]const u8,

    pub const json_field_names = .{
        .content_id = "contentId",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .title = "title",
    };
};
