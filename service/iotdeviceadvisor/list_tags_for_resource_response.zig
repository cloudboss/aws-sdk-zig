const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags attached to the IoT Device Advisor resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
