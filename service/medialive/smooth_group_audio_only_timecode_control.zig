/// Smooth Group Audio Only Timecode Control
pub const SmoothGroupAudioOnlyTimecodeControl = enum {
    passthrough,
    use_configured_clock,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .use_configured_clock = "USE_CONFIGURED_CLOCK",
    };
};
