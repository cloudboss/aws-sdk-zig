const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the CloudWatch RUM resource that you're adding tags to.
    resource_arn: []const u8,

    /// The list of key-value pairs to associate with the resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
