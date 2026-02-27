const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource to apply tags to.
    resource_arn: []const u8,

    /// Each tag consists of a tag key and a tag value. Tag keys and values are both
    /// required, but tag values can be empty strings.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
