/// The certificate chain algorithm provided by sidewalk.
pub const SigningAlg = enum {
    ed_25519,
    p256_r_1,

    pub const json_field_names = .{
        .ed_25519 = "Ed25519",
        .p256_r_1 = "P256r1",
    };
};
