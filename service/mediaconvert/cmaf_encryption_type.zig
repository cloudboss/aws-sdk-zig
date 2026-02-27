/// Specify the encryption scheme that you want the service to use when
/// encrypting your CMAF segments. Choose AES-CBC subsample or AES_CTR.
pub const CmafEncryptionType = enum {
    sample_aes,
    aes_ctr,

    pub const json_field_names = .{
        .sample_aes = "SAMPLE_AES",
        .aes_ctr = "AES_CTR",
    };
};
