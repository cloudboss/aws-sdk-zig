pub const WrappingKeySpec = enum {
    rsa_2048,
    rsa_3072,
    rsa_4096,
    sm2,

    pub const json_field_names = .{
        .rsa_2048 = "RSA_2048",
        .rsa_3072 = "RSA_3072",
        .rsa_4096 = "RSA_4096",
        .sm2 = "SM2",
    };
};
