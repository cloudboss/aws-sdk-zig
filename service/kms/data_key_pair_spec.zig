pub const DataKeyPairSpec = enum {
    rsa_2048,
    rsa_3072,
    rsa_4096,
    ecc_nist_p256,
    ecc_nist_p384,
    ecc_nist_p521,
    ecc_secg_p256_k1,
    sm2,
    ecc_nist_edwards25519,

    pub const json_field_names = .{
        .rsa_2048 = "RSA_2048",
        .rsa_3072 = "RSA_3072",
        .rsa_4096 = "RSA_4096",
        .ecc_nist_p256 = "ECC_NIST_P256",
        .ecc_nist_p384 = "ECC_NIST_P384",
        .ecc_nist_p521 = "ECC_NIST_P521",
        .ecc_secg_p256_k1 = "ECC_SECG_P256K1",
        .sm2 = "SM2",
        .ecc_nist_edwards25519 = "ECC_NIST_EDWARDS25519",
    };
};
