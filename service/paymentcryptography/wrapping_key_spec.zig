pub const WrappingKeySpec = enum {
    rsa_oaep_sha_256,
    rsa_oaep_sha_512,

    pub const json_field_names = .{
        .rsa_oaep_sha_256 = "RSA_OAEP_SHA_256",
        .rsa_oaep_sha_512 = "RSA_OAEP_SHA_512",
    };
};
