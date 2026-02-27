/// Use these settings to specify static color calibration metadata, as defined
/// by SMPTE ST 2086. These values don't affect the pixel values that are
/// encoded in the video stream. They are intended to help the downstream video
/// player display content in a way that reflects the intentions of the the
/// content creator.
pub const Hdr10Metadata = struct {
    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    blue_primary_x: ?i32,

    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    blue_primary_y: ?i32,

    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    green_primary_x: ?i32,

    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    green_primary_y: ?i32,

    /// Maximum light level among all samples in the coded video sequence, in units
    /// of candelas per square meter. This setting doesn't have a default value; you
    /// must specify a value that is suitable for the content.
    max_content_light_level: ?i32,

    /// Maximum average light level of any frame in the coded video sequence, in
    /// units of candelas per square meter. This setting doesn't have a default
    /// value; you must specify a value that is suitable for the content.
    max_frame_average_light_level: ?i32,

    /// Nominal maximum mastering display luminance in units of of 0.0001 candelas
    /// per square meter.
    max_luminance: ?i32,

    /// Nominal minimum mastering display luminance in units of of 0.0001 candelas
    /// per square meter
    min_luminance: ?i32,

    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    red_primary_x: ?i32,

    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    red_primary_y: ?i32,

    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    white_point_x: ?i32,

    /// HDR Master Display Information must be provided by a color grader, using
    /// color grading tools. Range is 0 to 50,000, each increment represents 0.00002
    /// in CIE1931 color coordinate. Note that this setting is not for color
    /// correction.
    white_point_y: ?i32,

    pub const json_field_names = .{
        .blue_primary_x = "BluePrimaryX",
        .blue_primary_y = "BluePrimaryY",
        .green_primary_x = "GreenPrimaryX",
        .green_primary_y = "GreenPrimaryY",
        .max_content_light_level = "MaxContentLightLevel",
        .max_frame_average_light_level = "MaxFrameAverageLightLevel",
        .max_luminance = "MaxLuminance",
        .min_luminance = "MinLuminance",
        .red_primary_x = "RedPrimaryX",
        .red_primary_y = "RedPrimaryY",
        .white_point_x = "WhitePointX",
        .white_point_y = "WhitePointY",
    };
};
