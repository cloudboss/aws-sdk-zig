/// M2ts Audio Interval
pub const M2tsAudioInterval = enum {
    video_and_fixed_intervals,
    video_interval,

    pub const json_field_names = .{
        .video_and_fixed_intervals = "VIDEO_AND_FIXED_INTERVALS",
        .video_interval = "VIDEO_INTERVAL",
    };
};
