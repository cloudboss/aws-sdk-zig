const aws = @import("aws");

/// The request structure to tag a resource with a tag key and value.
pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) to use to tag a resource.
    resource_arn: []const u8,

    /// The tags used to tag the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
