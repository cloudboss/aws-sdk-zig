const EncryptionAlgorithmOptions = @import("encryption_algorithm_options.zig").EncryptionAlgorithmOptions;
const HashAlgorithmOptions = @import("hash_algorithm_options.zig").HashAlgorithmOptions;

/// The configuration of a signing operation.
pub const SigningConfiguration = struct {
    /// The encryption algorithm options that are available for a code-signing job.
    encryption_algorithm_options: EncryptionAlgorithmOptions,

    /// The hash algorithm options that are available for a code-signing job.
    hash_algorithm_options: HashAlgorithmOptions,

    pub const json_field_names = .{
        .encryption_algorithm_options = "encryptionAlgorithmOptions",
        .hash_algorithm_options = "hashAlgorithmOptions",
    };
};
