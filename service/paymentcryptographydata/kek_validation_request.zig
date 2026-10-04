const SymmetricKeyAlgorithm = @import("symmetric_key_algorithm.zig").SymmetricKeyAlgorithm;
const RandomKeyMaxLength = @import("random_key_max_length.zig").RandomKeyMaxLength;

/// Parameter information for generating a KEK validation request during
/// node-to-node initialization.
pub const KekValidationRequest = struct {
    /// The key derivation algorithm to use for generating a KEK validation request.
    derive_key_algorithm: SymmetricKeyAlgorithm,

    /// The maximum length of the random key to generate for a KEK validation
    /// request.
    random_key_max_length: ?RandomKeyMaxLength = null,

    pub const json_field_names = .{
        .derive_key_algorithm = "DeriveKeyAlgorithm",
        .random_key_max_length = "RandomKeyMaxLength",
    };
};
