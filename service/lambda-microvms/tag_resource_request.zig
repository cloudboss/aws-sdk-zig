const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource to tag.
    resource: []const u8,

    /// The key-value pairs of tags to add to the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource = "Resource",
        .tags = "Tags",
    };
};
