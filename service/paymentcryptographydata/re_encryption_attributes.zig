const DukptEncryptionAttributes = @import("dukpt_encryption_attributes.zig").DukptEncryptionAttributes;
const SymmetricEncryptionAttributes = @import("symmetric_encryption_attributes.zig").SymmetricEncryptionAttributes;

/// Parameters that are required to perform reencryption operation.
pub const ReEncryptionAttributes = union(enum) {
    dukpt: ?DukptEncryptionAttributes,
    /// Parameters that are required to encrypt data using symmetric keys.
    symmetric: ?SymmetricEncryptionAttributes,

    pub const json_field_names = .{
        .dukpt = "Dukpt",
        .symmetric = "Symmetric",
    };
};
