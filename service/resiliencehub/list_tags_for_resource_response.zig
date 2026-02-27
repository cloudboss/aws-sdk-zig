const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Tags assigned to the resource. A tag is a label that you assign to an Amazon
    /// Web Services resource.
    /// Each tag consists of a key/value pair.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
