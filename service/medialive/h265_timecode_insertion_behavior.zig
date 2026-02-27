/// H265 Timecode Insertion Behavior
pub const H265TimecodeInsertionBehavior = enum {
    disabled,
    pic_timing_sei,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .pic_timing_sei = "PIC_TIMING_SEI",
    };
};
