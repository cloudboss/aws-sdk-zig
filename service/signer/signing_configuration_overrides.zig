const EncryptionAlgorithm = @import("encryption_algorithm.zig").EncryptionAlgorithm;
const HashAlgorithm = @import("hash_algorithm.zig").HashAlgorithm;

/// A signing configuration that overrides the default encryption or hash
/// algorithm of a
/// signing job.
pub const SigningConfigurationOverrides = struct {
    /// A specified override of the default encryption algorithm that is used in a
    /// code-signing
    /// job.
    encryption_algorithm: ?EncryptionAlgorithm = null,

    /// A specified override of the default hash algorithm that is used in a
    /// code-signing
    /// job.
    hash_algorithm: ?HashAlgorithm = null,

    pub const json_field_names = .{
        .encryption_algorithm = "encryptionAlgorithm",
        .hash_algorithm = "hashAlgorithm",
    };
};
