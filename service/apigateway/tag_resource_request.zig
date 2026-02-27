const aws = @import("aws");

/// Adds or updates a tag on a given resource.
pub const TagResourceRequest = struct {
    /// The ARN of a resource that can be tagged.
    resource_arn: []const u8,

    /// The key-value map of strings. The valid character set is [a-zA-Z+-=._:/].
    /// The tag key can be up to 128 characters and must not start with `aws:`. The
    /// tag value can be up to 256 characters.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
