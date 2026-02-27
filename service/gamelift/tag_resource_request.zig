const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that uniquely identifies
    /// the Amazon GameLift Servers resource that you want to assign tags to. Amazon
    /// GameLift Servers includes resource ARNs in
    /// the data object for the resource. You can retrieve the ARN by calling a
    /// `List` or `Describe` operation for the resource type.
    resource_arn: []const u8,

    /// A list of one or more tags to assign to the specified Amazon GameLift
    /// Servers resource. Tags are
    /// developer-defined and structured as key-value pairs. The maximum tag limit
    /// may be lower
    /// than stated. See [
    /// Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// for tagging limits.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
