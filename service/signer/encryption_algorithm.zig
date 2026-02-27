pub const EncryptionAlgorithm = enum {
    rsa,
    ecdsa,

    pub const json_field_names = .{
        .rsa = "RSA",
        .ecdsa = "ECDSA",
    };
};
