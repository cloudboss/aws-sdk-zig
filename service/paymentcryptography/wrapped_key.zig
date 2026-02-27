const KeyCheckValueAlgorithm = @import("key_check_value_algorithm.zig").KeyCheckValueAlgorithm;
const WrappedKeyMaterialFormat = @import("wrapped_key_material_format.zig").WrappedKeyMaterialFormat;

/// Parameter information for generating a WrappedKeyBlock for key exchange.
pub const WrappedKey = struct {
    /// The key check value (KCV) is used to check if all parties holding a given
    /// key have the same key or to detect that a key has changed.
    key_check_value: ?[]const u8,

    /// The algorithm that Amazon Web Services Payment Cryptography uses to
    /// calculate the key check value (KCV). It is used to validate the key
    /// integrity.
    ///
    /// For TDES keys, the KCV is computed by encrypting 8 bytes, each with value of
    /// zero, with the key to be checked and retaining the 3 highest order bytes of
    /// the encrypted result. For AES keys, the KCV is computed using a CMAC
    /// algorithm where the input data is 16 bytes of zero and retaining the 3
    /// highest order bytes of the encrypted result.
    key_check_value_algorithm: ?KeyCheckValueAlgorithm,

    /// Parameter information for generating a wrapped key using TR-31 or TR-34 skey
    /// exchange method.
    key_material: []const u8,

    /// The key block format of a wrapped key.
    wrapped_key_material_format: WrappedKeyMaterialFormat,

    /// The `KeyARN` of the wrapped key.
    wrapping_key_arn: []const u8,

    pub const json_field_names = .{
        .key_check_value = "KeyCheckValue",
        .key_check_value_algorithm = "KeyCheckValueAlgorithm",
        .key_material = "KeyMaterial",
        .wrapped_key_material_format = "WrappedKeyMaterialFormat",
        .wrapping_key_arn = "WrappingKeyArn",
    };
};
