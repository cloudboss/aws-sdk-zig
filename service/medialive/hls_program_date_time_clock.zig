/// Hls Program Date Time Clock
pub const HlsProgramDateTimeClock = enum {
    initialize_from_output_timecode,
    system_clock,

    pub const json_field_names = .{
        .initialize_from_output_timecode = "INITIALIZE_FROM_OUTPUT_TIMECODE",
        .system_clock = "SYSTEM_CLOCK",
    };
};
