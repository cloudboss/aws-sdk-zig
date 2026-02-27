/// If set to LOG, log each output's audio track loudness to a CSV file.
pub const AudioNormalizationLoudnessLogging = enum {
    log,
    dont_log,

    pub const json_field_names = .{
        .log = "LOG",
        .dont_log = "DONT_LOG",
    };
};
