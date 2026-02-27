pub const PrivateKeyAlgorithm = enum {
    rsa,
    ecdh_p256,
    ecdh_p384,
    ecdh_p521,

    pub const json_field_names = .{
        .rsa = "RSA",
        .ecdh_p256 = "ECDH_P256",
        .ecdh_p384 = "ECDH_P384",
        .ecdh_p521 = "ECDH_P521",
    };
};
