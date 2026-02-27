pub const EncryptionAlg = enum {
    aes128_cbc,
    aes192_cbc,
    aes256_cbc,
    des_ede3_cbc,
    none,

    pub const json_field_names = .{
        .aes128_cbc = "AES128_CBC",
        .aes192_cbc = "AES192_CBC",
        .aes256_cbc = "AES256_CBC",
        .des_ede3_cbc = "DES_EDE3_CBC",
        .none = "NONE",
    };
};
