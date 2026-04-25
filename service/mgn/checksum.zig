const EncryptionAlgorithm = @import("encryption_algorithm.zig").EncryptionAlgorithm;

/// A checksum structure used to verify data integrity.
pub const Checksum = struct {
    /// The encryption algorithm used to generate the checksum.
    encryption_algorithm: ?EncryptionAlgorithm = null,

    /// The hash value of the checksum.
    hash: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_algorithm = "encryptionAlgorithm",
        .hash = "hash",
    };
};
