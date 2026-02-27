/// Optional. Choose a specific entropy encoding mode only when you want to
/// override XAVC recommendations. If you choose the value auto, MediaConvert
/// uses the mode that the XAVC file format specifies given this output's
/// operating point.
pub const XavcEntropyEncoding = enum {
    auto,
    cabac,
    cavlc,

    pub const json_field_names = .{
        .auto = "AUTO",
        .cabac = "CABAC",
        .cavlc = "CAVLC",
    };
};
