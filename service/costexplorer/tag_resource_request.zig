const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const TagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource. For a list of supported
    /// resources, see
    /// [ResourceTag](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_ResourceTag.html).
    resource_arn: []const u8,

    /// A list of tag key-value pairs to be added to the resource.
    ///
    /// Each tag consists of a key and a value, and each key must be unique for the
    /// resource. The
    /// following restrictions apply to resource tags:
    ///
    /// * Although the maximum number of array members is 200, you can assign a
    ///   maximum of 50
    /// user-tags to one resource. The remaining are reserved for Amazon Web
    /// Services use
    ///
    /// * The maximum length of a key is 128 characters
    ///
    /// * The maximum length of a value is 256 characters
    ///
    /// * Keys and values can only contain alphanumeric characters, spaces, and any
    ///   of the
    /// following: `_.:/=+@-`
    ///
    /// * Keys and values are case sensitive
    ///
    /// * Keys and values are trimmed for any leading or trailing whitespaces
    ///
    /// * Don’t use `aws:` as a prefix for your keys. This prefix is reserved for
    /// Amazon Web Services use
    resource_tags: []const ResourceTag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_tags = "ResourceTags",
    };
};
