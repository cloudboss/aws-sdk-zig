const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// ARN of the resource for which tags are to be added or updated.
    resource_arn: []const u8,

    /// Array of tags to be added or updated.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
