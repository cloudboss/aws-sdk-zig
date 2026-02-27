pub const AlertCategory = enum {
    scheduling_error,
    playback_warning,
    info,

    pub const json_field_names = .{
        .scheduling_error = "SCHEDULING_ERROR",
        .playback_warning = "PLAYBACK_WARNING",
        .info = "INFO",
    };
};
