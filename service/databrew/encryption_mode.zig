pub const EncryptionMode = enum {
    ssekms,
    sses3,

    pub const json_field_names = .{
        .ssekms = "SSEKMS",
        .sses3 = "SSES3",
    };
};
