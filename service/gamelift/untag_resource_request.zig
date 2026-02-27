pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that uniquely identifies
    /// the Amazon GameLift Servers resource that you want to remove tags from.
    /// Amazon GameLift Servers includes resource ARNs in
    /// the data object for the resource. You can retrieve the ARN by calling a
    /// `List` or `Describe` operation for the resource type.
    resource_arn: []const u8,

    /// A list of one or more tag keys to remove from the specified Amazon GameLift
    /// Servers resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
