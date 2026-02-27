pub const RecordingMode = enum {
    disabled,
    interval,

    pub const json_field_names = .{
        .disabled = "Disabled",
        .interval = "Interval",
    };
};
