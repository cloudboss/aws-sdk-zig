pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the index, FAQ, data source, or other
    /// resource to remove a tag.
    /// For example, the ARN of an index is constructed as follows:
    /// *arn:aws:kendra:your-region:your-account-id:index/index-id*
    /// For information on how to construct an ARN for all types of Amazon Kendra
    /// resources, see
    /// [Resource
    /// types](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonkendra.html#amazonkendra-resources-for-iam-policies).
    resource_arn: []const u8,

    /// A list of tag keys to remove from the index, FAQ, data source, or other
    /// resource. If a tag
    /// key doesn't exist for the resource, it is ignored.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};
