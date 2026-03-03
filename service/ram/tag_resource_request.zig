const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the managed permission that you want to add tags to. You must specify
    /// *either*
    /// `resourceArn`, or `resourceShareArn`, but not both.
    resource_arn: ?[]const u8 = null,

    /// Specifies the [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the resource share that you want to add tags to. You must specify
    /// *either*
    /// `resourceShareArn`, or `resourceArn`, but not both.
    resource_share_arn: ?[]const u8 = null,

    /// A list of one or more tag key and value pairs. The tag key must be present
    /// and not be
    /// an empty string. The tag value must be present but can be an empty string.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .resource_share_arn = "resourceShareArn",
        .tags = "tags",
    };
};
