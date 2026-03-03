const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The user-defined tags that are applied to the resource. For more
    /// information, see [Tagging for cost allocation or attribute-based access
    /// control
    /// (ABAC)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
