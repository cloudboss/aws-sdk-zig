const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A label that consists of a customer-defined key and an optional value.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
