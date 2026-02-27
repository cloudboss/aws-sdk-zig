const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// The tags to assign to the resource. Each tag consists of a key/value pair.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
