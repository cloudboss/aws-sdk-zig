const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of resources.
    resource_arn: []const u8,

    /// The tags assigned to resources.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
