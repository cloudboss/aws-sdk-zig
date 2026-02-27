const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// Identifies a customer managed key in the account and Region.
    ///
    /// Specify the key ID or key ARN of the KMS key.
    ///
    /// For example:
    ///
    /// * Key ID: `1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// * Key ARN:
    ///   `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    ///
    /// To get the key ID and key ARN for a KMS key, use ListKeys or DescribeKey.
    key_id: []const u8,

    /// One or more tags. Each tag consists of a tag key and a tag value. The tag
    /// value can be an
    /// empty (null) string.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    ///
    /// You cannot have more than one tag on a KMS key with the same tag key. If you
    /// specify an
    /// existing tag key with a different tag value, KMS replaces the current tag
    /// value with the
    /// specified one.
    tags: []const Tag,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .tags = "Tags",
    };
};
