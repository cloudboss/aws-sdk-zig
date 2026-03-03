/// Placeholder documentation for VideoBlackFailoverSettings
pub const VideoBlackFailoverSettings = struct {
    /// A value used in calculating the threshold below which MediaLive considers a
    /// pixel to be 'black'. For the input to be considered black, every pixel in a
    /// frame must be below this threshold. The threshold is calculated as a
    /// percentage (expressed as a decimal) of white. Therefore .1 means 10% white
    /// (or 90% black). Note how the formula works for any color depth. For example,
    /// if you set this field to 0.1 in 10-bit color depth: (1023*0.1=102.3), which
    /// means a pixel value of 102 or less is 'black'. If you set this field to .1
    /// in an 8-bit color depth: (255*0.1=25.5), which means a pixel value of 25 or
    /// less is 'black'. The range is 0.0 to 1.0, with any number of decimal places.
    black_detect_threshold: ?f64 = null,

    /// The amount of time (in milliseconds) that the active input must be black
    /// before automatic input failover occurs.
    video_black_threshold_msec: ?i32 = null,

    pub const json_field_names = .{
        .black_detect_threshold = "BlackDetectThreshold",
        .video_black_threshold_msec = "VideoBlackThresholdMsec",
    };
};
