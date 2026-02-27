const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;

/// The encryption key used to encrypt this object.
pub const EncryptionKey = struct {
    /// The Amazon Resource Name (ARN) of the encryption key being used to encrypt
    /// this object.
    id: []const u8,

    /// The type of encryption key used by Amazon Translate to encrypt this object.
    type: EncryptionKeyType,

    pub const json_field_names = .{
        .id = "Id",
        .type = "Type",
    };
};
