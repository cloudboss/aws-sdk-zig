const EncryptionMode = @import("encryption_mode.zig").EncryptionMode;
const PaddingType = @import("padding_type.zig").PaddingType;

/// Parameters requried to encrypt plaintext data using symmetric keys.
pub const SymmetricEncryptionAttributes = struct {
    /// An input used to provide the intial state. If no value is provided, Amazon
    /// Web Services Payment Cryptography defaults it to zero.
    initialization_vector: ?[]const u8 = null,

    /// The block cipher method to use for encryption.
    mode: EncryptionMode,

    /// The padding to be included with the data.
    padding_type: ?PaddingType = null,

    pub const json_field_names = .{
        .initialization_vector = "InitializationVector",
        .mode = "Mode",
        .padding_type = "PaddingType",
    };
};
