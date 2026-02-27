/// When set to XDCAM, writes MPEG2 video streams into the QuickTime file using
/// XDCAM fourcc codes. This increases compatibility with Apple editors and
/// players, but may decrease compatibility with other players. Only applicable
/// when the video codec is MPEG2.
pub const MovMpeg2FourCCControl = enum {
    xdcam,
    mpeg,

    pub const json_field_names = .{
        .xdcam = "XDCAM",
        .mpeg = "MPEG",
    };
};
