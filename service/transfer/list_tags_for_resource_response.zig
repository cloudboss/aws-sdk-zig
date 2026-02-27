const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The ARN you specified to list the tags of.
    arn: ?[]const u8,

    /// When you can get additional results from the `ListTagsForResource` call, a
    /// `NextToken` parameter is returned in the output. You can then pass in a
    /// subsequent command to the `NextToken` parameter to continue listing
    /// additional tags.
    next_token: ?[]const u8,

    /// Key-value pairs that are assigned to a resource, usually for the purpose of
    /// grouping and searching for items. Tags are metadata that you define.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .arn = "Arn",
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
