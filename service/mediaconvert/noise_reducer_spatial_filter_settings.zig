/// Noise reducer filter settings for spatial filter.
pub const NoiseReducerSpatialFilterSettings = struct {
    /// Specify strength of post noise reduction sharpening filter, with 0 disabling
    /// the filter and 3 enabling it at maximum strength.
    post_filter_sharpen_strength: ?i32 = null,

    /// The speed of the filter, from -2 (lower speed) to 3 (higher speed), with 0
    /// being the nominal value.
    speed: ?i32 = null,

    /// Relative strength of noise reducing filter. Higher values produce stronger
    /// filtering.
    strength: ?i32 = null,

    pub const json_field_names = .{
        .post_filter_sharpen_strength = "PostFilterSharpenStrength",
        .speed = "Speed",
        .strength = "Strength",
    };
};
