/// Required when you set Codec to the value FRAME_CAPTURE.
pub const FrameCaptureSettings = struct {
    /// Frame capture will encode the first frame of the output stream, then one
    /// frame every framerateDenominator/framerateNumerator seconds. For example,
    /// settings of framerateNumerator = 1 and framerateDenominator = 3 (a rate of
    /// 1/3 frame per second) will capture the first frame, then 1 frame every 3s.
    /// Files will be named as filename.n.jpg where n is the 0-based sequence number
    /// of each Capture.
    framerate_denominator: ?i32 = null,

    /// Frame capture will encode the first frame of the output stream, then one
    /// frame every framerateDenominator/framerateNumerator seconds. For example,
    /// settings of framerateNumerator = 1 and framerateDenominator = 3 (a rate of
    /// 1/3 frame per second) will capture the first frame, then 1 frame every 3s.
    /// Files will be named as filename.NNNNNNN.jpg where N is the 0-based frame
    /// sequence number zero padded to 7 decimal places.
    framerate_numerator: ?i32 = null,

    /// Maximum number of captures (encoded jpg output files).
    max_captures: ?i32 = null,

    /// JPEG Quality - a higher value equals higher quality.
    quality: ?i32 = null,

    pub const json_field_names = .{
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .max_captures = "MaxCaptures",
        .quality = "Quality",
    };
};
