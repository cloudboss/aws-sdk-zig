const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// of the Amazon GameLift Streams resource that you want to apply tags to.
    resource_arn: []const u8,

    /// A list of tags, in the form of key-value pairs, to assign to the specified
    /// Amazon GameLift Streams resource.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
