/// Ignore this setting unless your input frame rate is 23.976 or 24 frames per
/// second (fps). Enable slow PAL to create a 25 fps output by relabeling the
/// video frames and resampling your audio. Note that enabling this setting will
/// slightly reduce the duration of your video. Related settings: You must also
/// set Framerate to 25.
pub const UncompressedSlowPal = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
