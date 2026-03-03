/// Tags are key-value pairs that can be associated with Step Functions state
/// machines and
/// activities.
///
/// An array of key-value pairs. For more information, see [Using
/// Cost Allocation
/// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Amazon Web Services Billing and Cost Management User
/// Guide*, and [Controlling Access Using IAM
/// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_iam-tags.html).
///
/// Tags may only contain Unicode letters, digits, white space, or these
/// symbols: `_ . : / = + - @`.
pub const Tag = struct {
    /// The key of a tag.
    key: ?[]const u8 = null,

    /// The value of a tag.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
