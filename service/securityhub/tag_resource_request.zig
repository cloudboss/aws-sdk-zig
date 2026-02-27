const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The ARN of the resource to apply the tags to.
    resource_arn: []const u8,

    /// The tags to add to the resource. You can add up to 50 tags at a time. The
    /// tag keys can be no longer than 128 characters. The tag values can be no
    /// longer than 256 characters.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
