pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. For a list of supported
    /// resources, see
    /// [ResourceTag](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_ResourceTag.html).
    resource_arn: []const u8,

    /// A list of tag keys associated with tags that need to be removed from the
    /// resource. If you
    /// specify a tag key that doesn't exist, it's ignored. Although the maximum
    /// number of array
    /// members is 200, user-tag maximum is 50. The remaining are reserved for
    /// Amazon Web Services use.
    resource_tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_tag_keys = "ResourceTagKeys",
    };
};
