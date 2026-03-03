const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Key-value pairs that are assigned to a resource, usually for the purpose of
    /// grouping and searching for items. Tags are metadata that you define.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
