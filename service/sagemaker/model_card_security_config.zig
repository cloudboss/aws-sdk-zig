/// Configure the security settings to protect model card data.
pub const ModelCardSecurityConfig = struct {
    /// A Key Management Service [key
    /// ID](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-id) to use for encrypting a model card.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
    };
};
