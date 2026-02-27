const KeyAttributes = @import("key_attributes.zig").KeyAttributes;
const WrappingKeySpec = @import("wrapping_key_spec.zig").WrappingKeySpec;

/// Parameter information for key material import using asymmetric RSA wrap and
/// unwrap key exchange method.
pub const ImportKeyCryptogram = struct {
    /// Specifies whether the key is exportable from the service.
    exportable: bool,

    /// The import token that initiates key import using the asymmetric RSA wrap and
    /// unwrap key exchange method into AWS Payment Cryptography. It expires after
    /// 30 days. You can use the same import token to import multiple keys to the
    /// same service account.
    import_token: []const u8,

    key_attributes: KeyAttributes,

    /// The RSA wrapped key cryptogram under import.
    wrapped_key_cryptogram: []const u8,

    /// The wrapping spec for the wrapped key cryptogram.
    wrapping_spec: ?WrappingKeySpec,

    pub const json_field_names = .{
        .exportable = "Exportable",
        .import_token = "ImportToken",
        .key_attributes = "KeyAttributes",
        .wrapped_key_cryptogram = "WrappedKeyCryptogram",
        .wrapping_spec = "WrappingSpec",
    };
};
