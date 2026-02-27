const DukptDerivationType = @import("dukpt_derivation_type.zig").DukptDerivationType;
const DukptKeyVariant = @import("dukpt_key_variant.zig").DukptKeyVariant;

/// Parameters required for encryption or decryption of data using DUKPT.
pub const DukptDerivationAttributes = struct {
    /// The key type derived using DUKPT from a Base Derivation Key (BDK) and Key
    /// Serial Number (KSN). This must be less than or equal to the strength of the
    /// BDK. For example, you can't use `AES_128` as a derivation type for a BDK of
    /// `AES_128` or `TDES_2KEY`
    dukpt_key_derivation_type: ?DukptDerivationType,

    /// The type of use of DUKPT, which can be for incoming data decryption,
    /// outgoing data encryption, or both.
    dukpt_key_variant: ?DukptKeyVariant,

    /// The unique identifier known as Key Serial Number (KSN) that comes from an
    /// encrypting device using DUKPT encryption method. The KSN is derived from the
    /// encrypting device unique identifier and an internal transaction counter.
    key_serial_number: []const u8,

    pub const json_field_names = .{
        .dukpt_key_derivation_type = "DukptKeyDerivationType",
        .dukpt_key_variant = "DukptKeyVariant",
        .key_serial_number = "KeySerialNumber",
    };
};
