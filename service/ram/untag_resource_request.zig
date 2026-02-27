pub const UntagResourceRequest = struct {
    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the managed permission that you want to remove tags from. You must
    /// specify either `resourceArn`, or `resourceShareArn`, but not
    /// both.
    resource_arn: ?[]const u8,

    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share that you want to remove tags from. The tags are
    /// removed from the resource share, not the resources in the resource share.
    /// You must specify either
    /// `resourceShareArn`, or `resourceArn`, but not both.
    resource_share_arn: ?[]const u8,

    /// Specifies a list of one or more tag keys that you want to remove.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_share_arn = "resourceShareArn",
        .tag_keys = "tagKeys",
    };
};
