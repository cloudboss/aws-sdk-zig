pub const S3EncryptionMode = enum {
    disabled,
    ssekms,
    sses3,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .ssekms = "SSEKMS",
        .sses3 = "SSES3",
    };
};
