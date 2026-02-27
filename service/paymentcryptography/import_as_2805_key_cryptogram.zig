const As2805KeyVariant = @import("as_2805_key_variant.zig").As2805KeyVariant;
const KeyAlgorithm = @import("key_algorithm.zig").KeyAlgorithm;
const KeyModesOfUse = @import("key_modes_of_use.zig").KeyModesOfUse;

/// Parameter information for key material import using AS2805 key cryptogram
/// format.
pub const ImportAs2805KeyCryptogram = struct {
    /// The cryptographic usage of the key under import.
    as_2805_key_variant: As2805KeyVariant,

    /// Specified whether the key is exportable. This data is immutable after the
    /// key is imported.
    exportable: bool,

    /// The key algorithm of the key under import.
    key_algorithm: KeyAlgorithm,

    key_modes_of_use: KeyModesOfUse,

    /// The wrapped key cryptogram under import.
    wrapped_key_cryptogram: []const u8,

    wrapping_key_identifier: []const u8,

    pub const json_field_names = .{
        .as_2805_key_variant = "As2805KeyVariant",
        .exportable = "Exportable",
        .key_algorithm = "KeyAlgorithm",
        .key_modes_of_use = "KeyModesOfUse",
        .wrapped_key_cryptogram = "WrappedKeyCryptogram",
        .wrapping_key_identifier = "WrappingKeyIdentifier",
    };
};
