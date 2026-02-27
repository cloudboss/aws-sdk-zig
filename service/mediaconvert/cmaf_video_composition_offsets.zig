/// Specify the video sample composition time offset mode in the output fMP4
/// TRUN box. For wider player compatibility, set Video composition offsets to
/// Unsigned or leave blank. The earliest presentation time may be greater than
/// zero, and sample composition time offsets will increment using unsigned
/// integers. For strict fMP4 video and audio timing, set Video composition
/// offsets to Signed. The earliest presentation time will be equal to zero, and
/// sample composition time offsets will increment using signed integers.
pub const CmafVideoCompositionOffsets = enum {
    signed,
    unsigned,

    pub const json_field_names = .{
        .signed = "SIGNED",
        .unsigned = "UNSIGNED",
    };
};
