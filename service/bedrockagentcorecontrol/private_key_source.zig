const KmsKeySourceType = @import("kms_key_source_type.zig").KmsKeySourceType;

/// Contains the private key source configuration for a JWT client assertion.
pub const PrivateKeySource = union(enum) {
    /// The KMS key source for the JWT client assertion.
    kms_key_source: ?KmsKeySourceType,

    pub const json_field_names = .{
        .kms_key_source = "kmsKeySource",
    };
};
