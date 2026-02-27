/// The encryption method to use.
pub const CmafEncryptionMethod = enum {
    sample_aes,
    aes_ctr,

    pub const json_field_names = .{
        .sample_aes = "SAMPLE_AES",
        .aes_ctr = "AES_CTR",
    };
};
