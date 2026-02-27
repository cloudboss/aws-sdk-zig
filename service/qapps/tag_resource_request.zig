const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource to tag.
    resource_arn: []const u8,

    /// The tags to associate with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceARN",
        .tags = "tags",
    };
};
