/// To place the MOOV atom at the beginning of your output, which is useful for
/// progressive downloading: Leave blank or choose Progressive download. To
/// place the MOOV at the end of your output: Choose Normal.
pub const F4vMoovPlacement = enum {
    progressive_download,
    normal,

    pub const json_field_names = .{
        .progressive_download = "PROGRESSIVE_DOWNLOAD",
        .normal = "NORMAL",
    };
};
