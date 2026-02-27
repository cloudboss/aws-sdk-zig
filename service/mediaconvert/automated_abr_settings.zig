const AutomatedAbrRule = @import("automated_abr_rule.zig").AutomatedAbrRule;

/// Use automated ABR to have MediaConvert set up the renditions in your ABR
/// package for you automatically, based on characteristics of your input video.
/// This feature optimizes video quality while minimizing the overall size of
/// your ABR package.
pub const AutomatedAbrSettings = struct {
    /// Specify the maximum average bitrate for MediaConvert to use in your
    /// automated ABR stack. If you don't specify a value, MediaConvert uses
    /// 8,000,000 (8 mb/s) by default. The average bitrate of your highest-quality
    /// rendition will be equal to or below this value, depending on the quality,
    /// complexity, and resolution of your content. Note that the instantaneous
    /// maximum bitrate may vary above the value that you specify.
    max_abr_bitrate: ?i32,

    /// Optional. Specify the QVBR quality level to use for all renditions in your
    /// automated ABR stack. To have MediaConvert automatically determine the
    /// quality level: Leave blank. To manually specify a quality level: Enter a
    /// value from 1 to 10. MediaConvert will use a quality level up to the value
    /// that you specify, depending on your source. For more information about QVBR
    /// quality levels, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/qvbr-guidelines.html
    max_quality_level: ?f64,

    /// Optional. The maximum number of renditions that MediaConvert will create in
    /// your automated ABR stack. The number of renditions is determined
    /// automatically, based on analysis of each job, but will never exceed this
    /// limit. When you set this to Auto in the console, which is equivalent to
    /// excluding it from your JSON job specification, MediaConvert defaults to a
    /// limit of 15.
    max_renditions: ?i32,

    /// Specify the minimum average bitrate for MediaConvert to use in your
    /// automated ABR stack. If you don't specify a value, MediaConvert uses 600,000
    /// (600 kb/s) by default. The average bitrate of your lowest-quality rendition
    /// will be near this value. Note that the instantaneous minimum bitrate may
    /// vary below the value that you specify.
    min_abr_bitrate: ?i32,

    /// Optional. Use Automated ABR rules to specify restrictions for the rendition
    /// sizes MediaConvert will create in your ABR stack. You can use these rules if
    /// your ABR workflow has specific rendition size requirements, but you still
    /// want MediaConvert to optimize for video quality and overall file size.
    rules: ?[]const AutomatedAbrRule,

    pub const json_field_names = .{
        .max_abr_bitrate = "MaxAbrBitrate",
        .max_quality_level = "MaxQualityLevel",
        .max_renditions = "MaxRenditions",
        .min_abr_bitrate = "MinAbrBitrate",
        .rules = "Rules",
    };
};
