const aws = @import("aws");

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon S3 Tables resource that you're
    /// applying tags to. The tagged resource can be a table bucket or a table. For
    /// a list of all S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    resource_arn: []const u8,

    /// The user-defined tag that you want to add to the specified S3 Tables
    /// resource. For more information, see [Tagging for cost allocation or
    /// attribute-based access control
    /// (ABAC)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html).
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .tags = "tags",
    };
};
