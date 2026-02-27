const aws = @import("aws");

/// Creates a new Tag resource to represent a tag.
pub const TagResourceRequest = struct {
    /// The resource ARN for the tag.
    resource_arn: []const u8,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
