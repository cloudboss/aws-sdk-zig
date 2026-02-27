const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the index, FAQ, data source, or other
    /// resource to add a tag.
    /// For example, the ARN of an index is constructed as follows:
    /// *arn:aws:kendra:your-region:your-account-id:index/index-id*
    /// For information on how to construct an ARN for all types of Amazon Kendra
    /// resources, see
    /// [Resource
    /// types](https://docs.aws.amazon.com/service-authorization/latest/reference/list_amazonkendra.html#amazonkendra-resources-for-iam-policies).
    resource_arn: []const u8,

    /// A list of tag keys to add to the index, FAQ, data source, or other resource.
    /// If a tag already
    /// exists, the existing value is replaced with the new value.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};
