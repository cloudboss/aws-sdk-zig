/// Frame Capture Interval Unit
pub const FrameCaptureIntervalUnit = enum {
    milliseconds,
    seconds,

    pub const json_field_names = .{
        .milliseconds = "MILLISECONDS",
        .seconds = "SECONDS",
    };
};
