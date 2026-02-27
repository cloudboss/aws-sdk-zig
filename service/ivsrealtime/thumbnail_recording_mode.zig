pub const ThumbnailRecordingMode = enum {
    interval,
    disabled,

    pub const json_field_names = .{
        .interval = "INTERVAL",
        .disabled = "DISABLED",
    };
};
