const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// Tag resource by ARN.
    resource_arn: []const u8,

    /// Tag resource by Tags.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
