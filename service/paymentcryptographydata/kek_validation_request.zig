const SymmetricKeyAlgorithm = @import("symmetric_key_algorithm.zig").SymmetricKeyAlgorithm;

/// Parameter information for generating a KEK validation request during
/// node-to-node initialization.
pub const KekValidationRequest = struct {
    /// The key derivation algorithm to use for generating a KEK validation request.
    derive_key_algorithm: SymmetricKeyAlgorithm,

    pub const json_field_names = .{
        .derive_key_algorithm = "DeriveKeyAlgorithm",
    };
};
