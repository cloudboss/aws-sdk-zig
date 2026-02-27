const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of tags associated with the DataBrew resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "Tags",
    };
};
