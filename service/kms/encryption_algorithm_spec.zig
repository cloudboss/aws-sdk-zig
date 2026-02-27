pub const EncryptionAlgorithmSpec = enum {
    symmetric_default,
    rsaes_oaep_sha_1,
    rsaes_oaep_sha_256,
    sm2_pke,

    pub const json_field_names = .{
        .symmetric_default = "SYMMETRIC_DEFAULT",
        .rsaes_oaep_sha_1 = "RSAES_OAEP_SHA_1",
        .rsaes_oaep_sha_256 = "RSAES_OAEP_SHA_256",
        .sm2_pke = "SM2PKE",
    };
};
