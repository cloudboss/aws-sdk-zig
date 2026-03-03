const aws = @import("aws");

const RelatedItemContent = @import("related_item_content.zig").RelatedItemContent;
const UserUnion = @import("user_union.zig").UserUnion;
const RelatedItemType = @import("related_item_type.zig").RelatedItemType;

/// A list of items that represent RelatedItems.
pub const SearchRelatedItemsResponseItem = struct {
    /// Time at which a related item was associated with a case.
    association_time: i64,

    /// Represents the content of a particular type of related item.
    content: RelatedItemContent,

    /// Represents the creator of the related item.
    performed_by: ?UserUnion = null,

    /// Unique identifier of a related item.
    related_item_id: []const u8,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Type of a related item.
    @"type": RelatedItemType,

    pub const json_field_names = .{
        .association_time = "associationTime",
        .content = "content",
        .performed_by = "performedBy",
        .related_item_id = "relatedItemId",
        .tags = "tags",
        .@"type" = "type",
    };
};
