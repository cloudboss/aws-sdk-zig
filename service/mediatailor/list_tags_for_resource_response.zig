const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tags associated with this resource. Tags are key-value pairs that you
    /// can associate with Amazon resources to help with organization, access
    /// control, and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
