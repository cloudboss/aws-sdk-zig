pub const ListTagsForResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the Amazon S3 Tables resource that you
    /// want to list tags for. The tagged resource can be a table bucket or a table.
    /// For a list of all S3 resources that support tagging, see [Managing tags for
    /// Amazon S3
    /// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#manage-tags).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
