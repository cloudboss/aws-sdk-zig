const WrappedKeyMaterialFormat = @import("wrapped_key_material_format.zig").WrappedKeyMaterialFormat;

/// The parameter information of the outgoing wrapped key block.
pub const WrappedWorkingKey = struct {
    /// The key check value (KCV) of the key contained within the outgoing
    /// TR31WrappedKeyBlock.
    ///
    /// The KCV is used to check if all parties holding a given key have the same
    /// key or to detect that a key has changed. For more information on KCV, see
    /// [KCV](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/terminology.html#terms.kcv) in the *Amazon Web Services Payment Cryptography User Guide*.
    key_check_value: []const u8,

    /// The wrapped key block of the outgoing transaction key.
    wrapped_key_material: []const u8,

    /// The key block format of the wrapped key.
    wrapped_key_material_format: WrappedKeyMaterialFormat,

    pub const json_field_names = .{
        .key_check_value = "KeyCheckValue",
        .wrapped_key_material = "WrappedKeyMaterial",
        .wrapped_key_material_format = "WrappedKeyMaterialFormat",
    };
};
