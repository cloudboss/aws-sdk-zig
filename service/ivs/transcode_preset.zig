pub const TranscodePreset = enum {
    higher_bandwidth_transcode_preset,
    constrained_bandwidth_transcode_preset,

    pub const json_field_names = .{
        .higher_bandwidth_transcode_preset = "HigherBandwidthTranscodePreset",
        .constrained_bandwidth_transcode_preset = "ConstrainedBandwidthTranscodePreset",
    };
};
