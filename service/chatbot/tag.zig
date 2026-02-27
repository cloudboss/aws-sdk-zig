/// A key-value pair. A tag consists of a tag key and a tag value. Tag keys and
/// tag values are both required, but tag values can be empty (null) strings.
///
/// Do not include confidential or sensitive information in this field.
///
/// For more information, see [User-Defined Tag
/// Restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html) in the *AWS Billing and Cost Management User Guide*.
pub const Tag = struct {
    /// The key of the tag.
    tag_key: []const u8,

    /// The value of the tag.
    tag_value: []const u8,

    pub const json_field_names = .{
        .tag_key = "TagKey",
        .tag_value = "TagValue",
    };
};
