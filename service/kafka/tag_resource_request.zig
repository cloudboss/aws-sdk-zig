const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the resource that's
    /// associated with the tags.
    resource_arn: []const u8,

    /// The key-value pair for the resource tag.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
