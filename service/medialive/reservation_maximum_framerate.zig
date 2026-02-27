/// Maximum framerate in frames per second (Outputs only)
pub const ReservationMaximumFramerate = enum {
    max_30_fps,
    max_60_fps,

    pub const json_field_names = .{
        .max_30_fps = "MAX_30_FPS",
        .max_60_fps = "MAX_60_FPS",
    };
};
