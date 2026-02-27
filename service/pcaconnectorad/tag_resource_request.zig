const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) that was returned when you created the
    /// resource.
    resource_arn: []const u8,

    /// Metadata assigned to a directory registration consisting of a key-value
    /// pair.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
