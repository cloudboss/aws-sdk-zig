const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
