const As2805KeyVariant = @import("as_2805_key_variant.zig").As2805KeyVariant;

/// Parameter information for key material export using AS2805 key cryptogram
/// format.
pub const ExportAs2805KeyCryptogram = struct {
    /// The cryptographic usage of the key under export.
    as_2805_key_variant: As2805KeyVariant,

    wrapping_key_identifier: []const u8,

    pub const json_field_names = .{
        .as_2805_key_variant = "As2805KeyVariant",
        .wrapping_key_identifier = "WrappingKeyIdentifier",
    };
};
