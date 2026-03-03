const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;
const WrappedKeyMaterial = @import("wrapped_key_material.zig").WrappedKeyMaterial;

/// Parameter information of a WrappedKeyBlock for encryption key exchange.
pub const WrappedKey = struct {
    /// The algorithm that Amazon Web Services Payment Cryptography uses to
    /// calculate the key check value (KCV). It is used to validate the key
    /// integrity.
    ///
    /// For TDES keys, the KCV is computed by encrypting 8 bytes, each with value of
    /// zero, with the key to be checked and retaining the 3 highest order bytes of
    /// the encrypted result. For AES keys, the KCV is computed using a CMAC
    /// algorithm where the input data is 16 bytes of zero and retaining the 3
    /// highest order bytes of the encrypted result.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm = null,

    /// Parameter information of a WrappedKeyBlock for encryption key exchange.
    wrapped_key_material: WrappedKeyMaterial,

    pub const json_field_names = .{
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
        .wrapped_key_material = "WrappedKeyMaterial",
    };
};
