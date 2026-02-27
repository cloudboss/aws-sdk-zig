/// Placeholder documentation for Algorithm
pub const Algorithm = enum {
    aes128,
    aes192,
    aes256,

    pub const json_field_names = .{
        .aes128 = "AES128",
        .aes192 = "AES192",
        .aes256 = "AES256",
    };
};
