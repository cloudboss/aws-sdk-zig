/// H264 Timecode Insertion Behavior
pub const H264TimecodeInsertionBehavior = enum {
    disabled,
    pic_timing_sei,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .pic_timing_sei = "PIC_TIMING_SEI",
    };
};
