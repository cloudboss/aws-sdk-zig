const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the behavior graph to assign the tags to.
    resource_arn: []const u8,

    /// The tags to assign to the behavior graph. You can add up to 50 tags. For
    /// each tag, you
    /// provide the tag key and the tag value. Each tag key can contain up to 128
    /// characters. Each
    /// tag value can contain up to 256 characters.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
