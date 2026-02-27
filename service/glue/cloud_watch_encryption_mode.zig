pub const CloudWatchEncryptionMode = enum {
    disabled,
    ssekms,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .ssekms = "SSEKMS",
    };
};
