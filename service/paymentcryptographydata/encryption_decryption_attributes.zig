const AsymmetricEncryptionAttributes = @import("asymmetric_encryption_attributes.zig").AsymmetricEncryptionAttributes;
const DukptEncryptionAttributes = @import("dukpt_encryption_attributes.zig").DukptEncryptionAttributes;
const EmvEncryptionAttributes = @import("emv_encryption_attributes.zig").EmvEncryptionAttributes;
const SymmetricEncryptionAttributes = @import("symmetric_encryption_attributes.zig").SymmetricEncryptionAttributes;

/// Parameters that are required to perform encryption and decryption
/// operations.
pub const EncryptionDecryptionAttributes = union(enum) {
    asymmetric: ?AsymmetricEncryptionAttributes,
    dukpt: ?DukptEncryptionAttributes,
    /// Parameters for plaintext encryption using EMV keys.
    emv: ?EmvEncryptionAttributes,
    /// Parameters that are required to perform encryption and decryption using
    /// symmetric keys.
    symmetric: ?SymmetricEncryptionAttributes,

    pub const json_field_names = .{
        .asymmetric = "Asymmetric",
        .dukpt = "Dukpt",
        .emv = "Emv",
        .symmetric = "Symmetric",
    };
};
