const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource for which to retrieve tags.
    resource_arn: []const u8,

    /// The key-value string map. The valid character set is [a-zA-Z+-=._:/]. The
    /// tag key can be
    /// up to 128 characters and must not start with `aws:`. The tag value can be up
    /// to
    /// 256 characters.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
