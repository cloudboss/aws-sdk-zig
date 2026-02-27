const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource.
    resource_arn: []const u8,

    /// Tags associated with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
