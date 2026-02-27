const aws = @import("aws");

const ContentStatus = @import("content_status.zig").ContentStatus;

/// Information about the content.
pub const ContentData = struct {
    /// The Amazon Resource Name (ARN) of the content.
    content_arn: []const u8,

    /// The identifier of the content.
    content_id: []const u8,

    /// The media type of the content.
    content_type: []const u8,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base. This should not be a QUICK_RESPONSES
    /// type knowledge
    /// base if you're storing Wisdom Content resource to it.
    knowledge_base_id: []const u8,

    /// The URI of the content.
    link_out_uri: ?[]const u8,

    /// A key/value map to store attributes without affecting tagging or
    /// recommendations.
    /// For example, when synchronizing data between an external system and Wisdom,
    /// you can store an external version identifier as metadata to utilize for
    /// determining drift.
    metadata: []const aws.map.StringMapEntry,

    /// The name of the content.
    name: []const u8,

    /// The identifier of the content revision.
    revision_id: []const u8,

    /// The status of the content.
    status: ContentStatus,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// The title of the content.
    title: []const u8,

    /// The URL of the content.
    url: []const u8,

    /// The expiration time of the URL as an epoch timestamp.
    url_expiry: i64,

    pub const json_field_names = .{
        .content_arn = "contentArn",
        .content_id = "contentId",
        .content_type = "contentType",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .link_out_uri = "linkOutUri",
        .metadata = "metadata",
        .name = "name",
        .revision_id = "revisionId",
        .status = "status",
        .tags = "tags",
        .title = "title",
        .url = "url",
        .url_expiry = "urlExpiry",
    };
};
