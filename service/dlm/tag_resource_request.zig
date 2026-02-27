const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// One or more tags.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
