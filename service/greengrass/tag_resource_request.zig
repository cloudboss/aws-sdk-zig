const aws = @import("aws");

/// A map of the key-value pairs for the resource tag.
pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "tags",
    };
};
