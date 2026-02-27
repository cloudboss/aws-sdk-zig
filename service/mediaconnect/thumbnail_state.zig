pub const ThumbnailState = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
