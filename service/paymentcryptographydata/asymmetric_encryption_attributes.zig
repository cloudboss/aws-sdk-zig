const PaddingType = @import("padding_type.zig").PaddingType;

/// Parameters for plaintext encryption using asymmetric keys.
pub const AsymmetricEncryptionAttributes = struct {
    /// The padding to be included with the data.
    padding_type: ?PaddingType,

    pub const json_field_names = .{
        .padding_type = "PaddingType",
    };
};
