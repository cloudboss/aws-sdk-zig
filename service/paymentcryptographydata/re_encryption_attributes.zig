const AsymmetricEncryptionAttributes = @import("asymmetric_encryption_attributes.zig").AsymmetricEncryptionAttributes;
const DukptEncryptionAttributes = @import("dukpt_encryption_attributes.zig").DukptEncryptionAttributes;
const SymmetricEncryptionAttributes = @import("symmetric_encryption_attributes.zig").SymmetricEncryptionAttributes;

/// Parameters that are required to perform reencryption operation.
pub const ReEncryptionAttributes = union(enum) {
    /// Specifies the parameters required to encrypt data using an asymmetric key
    /// pair. You must specify a `PaddingType`.
    asymmetric: ?AsymmetricEncryptionAttributes,
    /// Specifies the parameters required to encrypt data using DUKPT.
    dukpt: ?DukptEncryptionAttributes,
    /// Specifies the parameters required to encrypt data using symmetric keys.
    symmetric: ?SymmetricEncryptionAttributes,

    pub const json_field_names = .{
        .asymmetric = "Asymmetric",
        .dukpt = "Dukpt",
        .symmetric = "Symmetric",
    };
};
