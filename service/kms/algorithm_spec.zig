pub const AlgorithmSpec = enum {
    rsaes_pkcs1_v1_5,
    rsaes_oaep_sha_1,
    rsaes_oaep_sha_256,
    rsa_aes_key_wrap_sha_1,
    rsa_aes_key_wrap_sha_256,
    sm2_pke,

    pub const json_field_names = .{
        .rsaes_pkcs1_v1_5 = "RSAES_PKCS1_V1_5",
        .rsaes_oaep_sha_1 = "RSAES_OAEP_SHA_1",
        .rsaes_oaep_sha_256 = "RSAES_OAEP_SHA_256",
        .rsa_aes_key_wrap_sha_1 = "RSA_AES_KEY_WRAP_SHA_1",
        .rsa_aes_key_wrap_sha_256 = "RSA_AES_KEY_WRAP_SHA_256",
        .sm2_pke = "SM2PKE",
    };
};
