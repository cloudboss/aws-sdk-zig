pub const DataKeySpec = enum {
    aes_256,
    aes_128,

    pub const json_field_names = .{
        .aes_256 = "AES_256",
        .aes_128 = "AES_128",
    };
};
