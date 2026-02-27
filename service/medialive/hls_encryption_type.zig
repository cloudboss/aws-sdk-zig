/// Hls Encryption Type
pub const HlsEncryptionType = enum {
    aes128,
    sample_aes,

    pub const json_field_names = .{
        .aes128 = "AES128",
        .sample_aes = "SAMPLE_AES",
    };
};
