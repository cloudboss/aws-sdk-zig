/// Optional. Choose the scan line type for this output. If you don't specify a
/// value, MediaConvert will create a progressive output.
pub const Vc3InterlaceMode = enum {
    interlaced,
    progressive,

    pub const json_field_names = .{
        .interlaced = "INTERLACED",
        .progressive = "PROGRESSIVE",
    };
};
