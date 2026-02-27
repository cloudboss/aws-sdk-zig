pub const Algorithm = enum {
    aes_128,
    aes_192,
    aes_256,

    pub const json_field_names = .{
        .aes_128 = "aes128",
        .aes_192 = "aes192",
        .aes_256 = "aes256",
    };
};
