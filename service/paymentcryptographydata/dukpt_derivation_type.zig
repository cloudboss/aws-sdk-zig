pub const DukptDerivationType = enum {
    tdes_2_key,
    tdes_3_key,
    aes_128,
    aes_192,
    aes_256,

    pub const json_field_names = .{
        .tdes_2_key = "TDES_2KEY",
        .tdes_3_key = "TDES_3KEY",
        .aes_128 = "AES_128",
        .aes_192 = "AES_192",
        .aes_256 = "AES_256",
    };
};
