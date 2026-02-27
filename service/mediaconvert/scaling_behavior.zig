/// Specify the video Scaling behavior when your output has a different
/// resolution than your input. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/video-scaling.html
pub const ScalingBehavior = enum {
    default,
    stretch_to_output,
    fit,
    fit_no_upscale,
    fill,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .stretch_to_output = "STRETCH_TO_OUTPUT",
        .fit = "FIT",
        .fit_no_upscale = "FIT_NO_UPSCALE",
        .fill = "FILL",
    };
};
