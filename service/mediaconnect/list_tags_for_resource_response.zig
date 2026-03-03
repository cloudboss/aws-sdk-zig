const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A map from tag keys to values. Tag keys can have a maximum character length
    /// of 128 characters, and tag values can have a maximum length of 256
    /// characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
