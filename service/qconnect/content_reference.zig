const ReferenceType = @import("reference_type.zig").ReferenceType;

/// Reference information about the content.
pub const ContentReference = struct {
    /// The Amazon Resource Name (ARN) of the content.
    content_arn: ?[]const u8 = null,

    /// The identifier of the content.
    content_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: ?[]const u8 = null,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge base.
    knowledge_base_id: ?[]const u8 = null,

    /// The type of reference content.
    reference_type: ?ReferenceType = null,

    /// The web URL of the source content.
    source_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_arn = "contentArn",
        .content_id = "contentId",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .reference_type = "referenceType",
        .source_url = "sourceURL",
    };
};
