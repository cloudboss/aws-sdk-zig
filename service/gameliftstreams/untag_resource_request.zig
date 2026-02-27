pub const UntagResourceRequest = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// of the Amazon GameLift Streams resource that you want to remove tags from.
    resource_arn: []const u8,

    /// A list of tag keys to remove from the specified Amazon GameLift Streams
    /// resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tag_keys = "TagKeys",
    };
};
