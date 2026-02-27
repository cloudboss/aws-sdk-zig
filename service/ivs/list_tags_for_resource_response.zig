const aws = @import("aws");

pub const ListTagsForResourceResponse = struct {
    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .tags = "tags",
    };
};
