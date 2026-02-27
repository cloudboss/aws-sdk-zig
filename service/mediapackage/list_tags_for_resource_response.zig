const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
