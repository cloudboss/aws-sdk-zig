pub const SSEType = enum {
    aes256,
    kms,

    pub const json_field_names = .{
        .aes256 = "AES256",
        .kms = "KMS",
    };
};
