pub const UntagResourceRequest = struct {
    /// Identifies the KMS key from which you are removing tags.
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

    /// One or more tag keys. Specify only the tag keys, not the tag values.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .tag_keys = "TagKeys",
    };
};
