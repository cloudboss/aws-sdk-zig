/// Specify the encryption mode that you used to encrypt your input files.
pub const DecryptionMode = enum {
    aes_ctr,
    aes_cbc,
    aes_gcm,

    pub const json_field_names = .{
        .aes_ctr = "AES_CTR",
        .aes_cbc = "AES_CBC",
        .aes_gcm = "AES_GCM",
    };
};
