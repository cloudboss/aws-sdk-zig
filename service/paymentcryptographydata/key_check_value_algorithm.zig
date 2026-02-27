pub const KeyCheckValueAlgorithm = enum {
    cmac,
    ansi_x9_24,
    hmac,
    sha_1,

    pub const json_field_names = .{
        .cmac = "CMAC",
        .ansi_x9_24 = "ANSI_X9_24",
        .hmac = "HMAC",
        .sha_1 = "SHA_1",
    };
};
