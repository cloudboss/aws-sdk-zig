/// Encrypts the segments with the given encryption scheme. Leave blank to
/// disable. Selecting 'Disabled' in the web interface also disables encryption.
pub const HlsEncryptionType = enum {
    aes128,
    sample_aes,

    pub const json_field_names = .{
        .aes128 = "AES128",
        .sample_aes = "SAMPLE_AES",
    };
};
