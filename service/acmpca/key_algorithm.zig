pub const KeyAlgorithm = enum {
    rsa_2048,
    rsa_3072,
    rsa_4096,
    ec_prime_256_v_1,
    ec_secp_384_r_1,
    ec_secp_521_r_1,
    ml_dsa_44,
    ml_dsa_65,
    ml_dsa_87,
    sm2,

    pub const json_field_names = .{
        .rsa_2048 = "RSA_2048",
        .rsa_3072 = "RSA_3072",
        .rsa_4096 = "RSA_4096",
        .ec_prime_256_v_1 = "EC_prime256v1",
        .ec_secp_384_r_1 = "EC_secp384r1",
        .ec_secp_521_r_1 = "EC_secp521r1",
        .ml_dsa_44 = "ML_DSA_44",
        .ml_dsa_65 = "ML_DSA_65",
        .ml_dsa_87 = "ML_DSA_87",
        .sm2 = "SM2",
    };
};
