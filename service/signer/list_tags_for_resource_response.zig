const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of tags associated with the signing profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
