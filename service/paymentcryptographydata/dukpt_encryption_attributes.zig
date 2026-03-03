const DukptDerivationType = @import("dukpt_derivation_type.zig").DukptDerivationType;
const DukptKeyVariant = @import("dukpt_key_variant.zig").DukptKeyVariant;
const DukptEncryptionMode = @import("dukpt_encryption_mode.zig").DukptEncryptionMode;

/// Parameters that are required to encrypt plaintext data using DUKPT.
pub const DukptEncryptionAttributes = struct {
    /// The key type encrypted using DUKPT from a Base Derivation Key (BDK) and Key
    /// Serial Number (KSN). This must be less than or equal to the strength of the
    /// BDK. For example, you can't use `AES_128` as a derivation type for a BDK of
    /// `AES_128` or `TDES_2KEY`
    dukpt_key_derivation_type: ?DukptDerivationType = null,

    /// The type of use of DUKPT, which can be incoming data decryption, outgoing
    /// data encryption, or both.
    dukpt_key_variant: ?DukptKeyVariant = null,

    /// An input used to provide the intial state. If no value is provided, Amazon
    /// Web Services Payment Cryptography defaults it to zero.
    initialization_vector: ?[]const u8 = null,

    /// The unique identifier known as Key Serial Number (KSN) that comes from an
    /// encrypting device using DUKPT encryption method. The KSN is derived from the
    /// encrypting device unique identifier and an internal transaction counter.
    key_serial_number: []const u8,

    /// The block cipher method to use for encryption.
    ///
    /// The default is CBC.
    mode: ?DukptEncryptionMode = null,

    pub const json_field_names = .{
        .dukpt_key_derivation_type = "DukptKeyDerivationType",
        .dukpt_key_variant = "DukptKeyVariant",
        .initialization_vector = "InitializationVector",
        .key_serial_number = "KeySerialNumber",
        .mode = "Mode",
    };
};
