pub const MemoryView = enum {
    full,
    without_decryption,

    pub const json_field_names = .{
        .full = "FULL",
        .without_decryption = "WITHOUT_DECRYPTION",
    };
};
