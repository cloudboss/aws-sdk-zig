/// When you use the setting Time delta to adjust the sync between your sidecar
/// captions and your video, use this setting to specify the units for the delta
/// that you specify. When you don't specify a value for Time delta units,
/// MediaConvert uses seconds by default.
pub const FileSourceTimeDeltaUnits = enum {
    seconds,
    milliseconds,

    pub const json_field_names = .{
        .seconds = "SECONDS",
        .milliseconds = "MILLISECONDS",
    };
};
