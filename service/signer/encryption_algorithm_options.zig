const EncryptionAlgorithm = @import("encryption_algorithm.zig").EncryptionAlgorithm;

/// The encryption algorithm options that are available to a code-signing job.
pub const EncryptionAlgorithmOptions = struct {
    /// The set of accepted encryption algorithms that are allowed in a code-signing
    /// job.
    allowed_values: []const EncryptionAlgorithm,

    /// The default encryption algorithm that is used by a code-signing job.
    default_value: EncryptionAlgorithm,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .default_value = "defaultValue",
    };
};
