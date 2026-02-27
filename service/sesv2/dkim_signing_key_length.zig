pub const DkimSigningKeyLength = enum {
    rsa_1024_bit,
    rsa_2048_bit,

    pub const json_field_names = .{
        .rsa_1024_bit = "RSA_1024_BIT",
        .rsa_2048_bit = "RSA_2048_BIT",
    };
};
