/// Parameter information for key material import using symmetric TR-31 key
/// exchange method.
pub const ImportTr31KeyBlock = struct {
    /// The TR-31 wrapped key block to import.
    wrapped_key_block: []const u8,

    /// The `KeyARN` of the key that will decrypt or unwrap a TR-31 key block during
    /// import.
    wrapping_key_identifier: []const u8,

    pub const json_field_names = .{
        .wrapped_key_block = "WrappedKeyBlock",
        .wrapping_key_identifier = "WrappingKeyIdentifier",
    };
};
