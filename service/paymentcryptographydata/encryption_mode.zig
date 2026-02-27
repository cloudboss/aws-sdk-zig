pub const EncryptionMode = enum {
    ecb,
    cbc,
    cfb,
    cfb1,
    cfb8,
    cfb64,
    cfb128,
    ofb,

    pub const json_field_names = .{
        .ecb = "ECB",
        .cbc = "CBC",
        .cfb = "CFB",
        .cfb1 = "CFB1",
        .cfb8 = "CFB8",
        .cfb64 = "CFB64",
        .cfb128 = "CFB128",
        .ofb = "OFB",
    };
};
