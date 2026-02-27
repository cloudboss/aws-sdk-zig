/// Mpeg2 Timecode Insertion Behavior
pub const Mpeg2TimecodeInsertionBehavior = enum {
    disabled,
    gop_timecode,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .gop_timecode = "GOP_TIMECODE",
    };
};
