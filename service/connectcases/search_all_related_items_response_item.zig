const aws = @import("aws");

const RelatedItemContent = @import("related_item_content.zig").RelatedItemContent;
const UserUnion = @import("user_union.zig").UserUnion;
const RelatedItemType = @import("related_item_type.zig").RelatedItemType;

/// A list of items that represent RelatedItems. This data type is similar to
/// [SearchRelatedItemsResponseItem](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_SearchRelatedItemsResponseItem.html) except Search**All**RelatedItemsResponseItem has a caseId field.
pub const SearchAllRelatedItemsResponseItem = struct {
    /// Time at which a related item was associated with a case.
    association_time: i64,

    /// A unique identifier of the case.
    case_id: []const u8,

    content: RelatedItemContent,

    performed_by: ?UserUnion,

    /// Unique identifier of a related item.
    related_item_id: []const u8,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry,

    /// Type of a related item.
    @"type": RelatedItemType,

    pub const json_field_names = .{
        .association_time = "associationTime",
        .case_id = "caseId",
        .content = "content",
        .performed_by = "performedBy",
        .related_item_id = "relatedItemId",
        .tags = "tags",
        .@"type" = "type",
    };
};
