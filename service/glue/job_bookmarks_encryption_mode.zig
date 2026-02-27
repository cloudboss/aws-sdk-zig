pub const JobBookmarksEncryptionMode = enum {
    disabled,
    csekms,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .csekms = "CSEKMS",
    };
};
