const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// A list of all tags associated with a medical imaging resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
