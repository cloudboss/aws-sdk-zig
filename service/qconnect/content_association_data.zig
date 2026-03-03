const aws = @import("aws");

const ContentAssociationContents = @import("content_association_contents.zig").ContentAssociationContents;
const ContentAssociationType = @import("content_association_type.zig").ContentAssociationType;

/// Information about the content association.
pub const ContentAssociationData = struct {
    /// The content association.
    association_data: ContentAssociationContents,

    /// The type of association.
    association_type: ContentAssociationType,

    /// The Amazon Resource Name (ARN) of the content.
    content_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the content association.
    content_association_arn: []const u8,

    /// The identifier of the content association. Can be either the ID or the ARN.
    /// URLs cannot contain the ARN.
    content_association_id: []const u8,

    /// The identifier of the content.
    content_id: []const u8,

    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The identifier of the knowledge base.
    knowledge_base_id: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .association_data = "associationData",
        .association_type = "associationType",
        .content_arn = "contentArn",
        .content_association_arn = "contentAssociationArn",
        .content_association_id = "contentAssociationId",
        .content_id = "contentId",
        .knowledge_base_arn = "knowledgeBaseArn",
        .knowledge_base_id = "knowledgeBaseId",
        .tags = "tags",
    };
};
