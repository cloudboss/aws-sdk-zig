/// Specify how you want MediaConvert to determine the fragment length. Choose
/// Exact to have the encoder use the exact length that you specify with the
/// setting Fragment length. This might result in extra I-frames. Choose
/// Multiple of GOP to have the encoder round up the segment lengths to match
/// the next GOP boundary.
pub const MsSmoothFragmentLengthControl = enum {
    exact,
    gop_multiple,

    pub const json_field_names = .{
        .exact = "EXACT",
        .gop_multiple = "GOP_MULTIPLE",
    };
};
