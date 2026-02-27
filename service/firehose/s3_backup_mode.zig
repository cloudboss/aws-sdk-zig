pub const S3BackupMode = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "Disabled",
        .enabled = "Enabled",
    };
};
