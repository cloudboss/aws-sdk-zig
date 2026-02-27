pub const EncryptionMethod = enum {
    aes_128,
    sample_aes,

    pub const json_field_names = .{
        .aes_128 = "AES_128",
        .sample_aes = "SAMPLE_AES",
    };
};
