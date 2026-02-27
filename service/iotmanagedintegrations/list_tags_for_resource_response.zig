const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A set of key/value pairs that are used to manage the resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
