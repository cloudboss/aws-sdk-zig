const aws = @import("aws");

/// Request of adding tag to the resource
pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the resource that's tagged.
    resource_arn: []const u8,

    /// The tags associated with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
