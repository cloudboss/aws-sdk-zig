/// The configuration information for the customer managed key used for
/// encryption.
pub const ServerSideEncryptionConfiguration = struct {
    /// The customer managed key used for encryption. For more information about
    /// setting up a customer managed key for Amazon Q in Connect, see [Enable
    /// Amazon Q in Connect for your
    /// instance](https://docs.aws.amazon.com/connect/latest/adminguide/enable-q.html). For information about valid ID values, see [Key identifiers (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id).
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
    };
};
