const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// ARN of a resource tag.
    resource_arn: []const u8,

    /// Tags assigned to a resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
