const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// The tag values that are assigned to the behavior graph. The request returns
    /// up to 50 tag
    /// values.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
