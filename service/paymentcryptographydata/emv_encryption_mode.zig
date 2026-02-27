pub const EmvEncryptionMode = enum {
    ecb,
    cbc,

    pub const json_field_names = .{
        .ecb = "ECB",
        .cbc = "CBC",
    };
};
