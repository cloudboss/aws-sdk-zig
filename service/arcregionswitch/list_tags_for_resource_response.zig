const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags for a resource.
    resource_tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_tags = "resourceTags",
    };
};
